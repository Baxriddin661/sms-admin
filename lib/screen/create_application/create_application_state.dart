import 'package:etcsms/model/template_create_model.dart';

class CreateApplicationState {
  final List<TemplateCreateModel> templates;

  CreateApplicationState(this.templates);

  CreateApplicationState init() {
    return CreateApplicationState([]);
  }

  CreateApplicationState clone() {
    return CreateApplicationState(templates);
  }
}

class ApplicationCreatedState extends CreateApplicationState {
  ApplicationCreatedState(super.templates);
}
