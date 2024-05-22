import 'package:bloc/bloc.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/model/template_update_model.dart';
import 'package:etcsms/repository/rest_client.dart';

import '../../global/shared_data_provider.dart';
import 'templates_event.dart';
import 'templates_state.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  final RestClient restClient = locator.get<RestClient>();
  final SharedData sharedData = locator.get<SharedData>();

  TemplatesBloc() : super(TemplatesState(getRandomString(10)).init()) {
    on<InitEvent>(_init);
    on<UpdateTemplateEvent>(_update);
  }

  void _init(InitEvent event, Emitter<TemplatesState> emit) async {
    emit(state.clone());
  }

  void _update(UpdateTemplateEvent event, Emitter<TemplatesState> emit) async {
    TemplateUpdateModel model =
        TemplateUpdateModel(id: event.model.id, status: event.model.status);
    await restClient.updateTemplateStatus(model);
    emit(TemplatesState(getRandomString(10)));
  }
}
