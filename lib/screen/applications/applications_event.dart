import 'package:etcsms/model/application_model.dart';

import '../../model/application_update_model.dart';

abstract class ApplicationsEvent {}

class InitEvent extends ApplicationsEvent {}

class UpdateApplicationEvent extends ApplicationsEvent {
  final ApplicationUpdateModel model;

  UpdateApplicationEvent(this.model);
}
