
import 'package:etcsms/model/template_update_model.dart';

abstract class TemplatesEvent {}

class InitEvent extends TemplatesEvent {}

class UpdateTemplateEvent extends TemplatesEvent {
  final TemplateUpdateModel model;

  UpdateTemplateEvent(this.model);
}
