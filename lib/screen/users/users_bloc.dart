import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:etcsms/repository/rest_client.dart';

import '../../global/shared_data_provider.dart';
import '../../manager/locator.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final SharedData sharedData = locator.get<SharedData>();
  final RestClient restClient = locator.get<RestClient>();

  UsersBloc() : super(UsersState(viewKey: 'key').init()) {
    on<InitEvent>(_init);
    on<RefreshListingEvent>(_refreshListing);
  }

  void _init(InitEvent event, Emitter<UsersState> emit) async {
    emit(state.clone());
  }
  void _refreshListing(RefreshListingEvent event, Emitter<UsersState> emit) async {
    emit(state.refreshListing(getRandomString(10)));
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
