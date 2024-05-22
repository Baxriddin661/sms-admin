import 'package:bloc/bloc.dart';
import 'package:etcsms/model/application_model.dart';
import 'package:etcsms/repository/rest_client.dart';

import '../../global/shared_data_provider.dart';
import '../../manager/locator.dart';
import '../../model/application_update_model.dart';
import 'applications_event.dart';
import 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final SharedData sharedData = locator.get<SharedData>();
  final RestClient restClient = locator.get<RestClient>();

  ApplicationsBloc() : super(ApplicationsState(getRandomString(10)).init()) {
    on<InitEvent>(_init);
    on<UpdateApplicationEvent>(_update);
  }

  void _init(InitEvent event, Emitter<ApplicationsState> emit) async {
    emit(state.clone());
  }

  void _update(
      UpdateApplicationEvent event, Emitter<ApplicationsState> emit) async {
    ApplicationUpdateModel model = ApplicationUpdateModel(
      id: event.model.id,
      status: event.model.status,
      comment: event.model.comment,
    );

    await restClient.updateApplicationStatus(model);
    emit(ApplicationsState(getRandomString(10)));
  }
}
