import 'package:bloc/bloc.dart';
import 'package:etcsms/manager/locator.dart';

import '../../global/shared_data_provider.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final SharedData sharedData = locator.get<SharedData>();
  DashboardBloc() : super(DashboardState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<DashboardState> emit) async {
    emit(state.clone());
  }
}
