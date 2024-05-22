import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:etcsms/config/dio_configurer.dart';
import 'package:etcsms/manager/loader_manager.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../manager/local_storage_manager.dart';
import '../../manager/locator.dart';
import '../../repository/rest_client.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(userModel: null));
  final LocalStorageManager localStorage = locator.get<LocalStorageManager>();
  final RestClient restClient = locator.get<RestClient>();
  final DioConfigurer dioConfigurer = locator.get<DioConfigurer>();
  final TextEditingController login = TextEditingController();
  final TextEditingController password = TextEditingController();

  void logIn() async {
    var loginText = login.text;
    var passwordText = password.text;
    if (loginText.isEmpty || passwordText.isEmpty) {
      return;
    }
    loaderManager.showLoader();
    final restClient = locator.get<RestClient>();

    var responseData = await restClient.login(loginText, passwordText);
    var token = responseData.accessToken;
    await localStorage.writeToken(token);
    await dioConfigurer.attachTokenToDio(token);
    Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

    try {
      // Extracting data from the decoded token
      await Future.delayed(Duration(seconds: 1));
      String userLogin = decodedToken['sub'];
      var response = await restClient.profileMe(userLogin);
      var userModel = response;
      emit(state.copyWith(userModel: userModel));
    } catch (e) {
      print(e);
    }

    loaderManager.hideLoader();
  }
}
