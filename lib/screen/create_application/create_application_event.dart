import 'package:etcsms/model/template_create_model.dart';

abstract class CreateApplicationEvent {}

class InitEvent extends CreateApplicationEvent {}
class SubmitApplicationEvent extends CreateApplicationEvent {}
class AddTemplateEvent extends CreateApplicationEvent {
  final TemplateCreateModel model;

  AddTemplateEvent(this.model);
}
