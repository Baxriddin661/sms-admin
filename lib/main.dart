import 'package:etcsms/global/shared_data_provider.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'config/dio_configurer.dart';
import 'manager/local_storage_manager.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  static const String title = 'ETC sms admin';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: title,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
      );

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: $appRoutes,
    initialLocation: "/dashboard/applications",
    redirect: (context, state) async {
      final LocalStorageManager localStorage =
          locator.get<LocalStorageManager>();
      final DioConfigurer dioConfigurer = locator.get<DioConfigurer>();
      final SharedData sharedData = locator.get<SharedData>();

      final path = state.fullPath;
      var token = await localStorage.readToken();
      if (token == null || token.isEmpty) {
        return LoginScreenRoute().location;
      } else {
        var restClient = await dioConfigurer.attachTokenToDio(token);
        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        // Extracting data from the decoded token
        String userLogin = decodedToken['sub'];
        try {
          var responseData = await restClient.profileMe(userLogin);
          sharedData.userModel = responseData;
          if (path == LoginScreenRoute().location) {
            return ApplicationListingRoute().location;
          }
          return null;
        } catch (e) {
          return LoginScreenRoute().location;
        }
      }
    },
  );
}
