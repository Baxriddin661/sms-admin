/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
import 'package:etcsms/model/template_create_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_application_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateApplicationModel {

    //example json
  /*
  {
  "abonentId": 76,
  "type": "ADDING_TEMPLATE",
  "templates": [
    {
      "text": "text00h2o 11232221212",
      "type": "SERVICE"
    }
  ]
}
   */

    //fields
  final int? abonentId;
  final int? applicationId;
  final String? type;
  final List<TemplateCreateModel>? templates;

  CreateApplicationModel(this.abonentId, this.type, this.templates, this.applicationId);

  factory CreateApplicationModel.fromJson(Map<String, dynamic> json) => _$CreateApplicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateApplicationModelToJson(this);
}
