import 'package:bloc/bloc.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/model/create_application_model.dart';

import '../../global/shared_data_provider.dart';
import '../../manager/loader_manager.dart';
import '../../repository/rest_client.dart';
import 'create_application_event.dart';
import 'create_application_state.dart';

class CreateApplicationBloc
    extends Bloc<CreateApplicationEvent, CreateApplicationState> {
  final RestClient restClient = locator.get<RestClient>();
  final SharedData sharedData = locator.get<SharedData>();
  LoaderManager loaderManager = locator.get<LoaderManager>();

  CreateApplicationBloc() : super(CreateApplicationState([]).init()) {
    on<InitEvent>(_init);
    on<AddTemplateEvent>(_addTemplate);
    on<SubmitApplicationEvent>(_createApplication);
  }

  void _init(InitEvent event, Emitter<CreateApplicationState> emit) async {
    emit(state.clone());
  }

  void _addTemplate(
      AddTemplateEvent event, Emitter<CreateApplicationState> emit) {
    emit(state.clone()..templates.add(event.model));
  }

  void _createApplication(SubmitApplicationEvent event,
      Emitter<CreateApplicationState> emit) async {
    CreateApplicationModel model = CreateApplicationModel(
        sharedData.userModel!.id, 'ADDING_TEMPLATE', null, null);
    loaderManager.showLoader();
    final applicationModel = await restClient.applicationCreate(model);
    CreateApplicationModel templateCreateModel = CreateApplicationModel(
        sharedData.userModel!.id,
        'ADDING_TEMPLATE',
        state.templates,
        applicationModel.id);
    await restClient.templateCreate(templateCreateModel);
    loaderManager.hideLoader();
    emit(ApplicationCreatedState(state.templates));
  }
}
