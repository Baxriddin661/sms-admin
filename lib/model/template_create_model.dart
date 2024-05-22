/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
import 'package:json_annotation/json_annotation.dart';

part 'template_create_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TemplateCreateModel {

    //example json
  final String text;
  final String type;

    //fields

  TemplateCreateModel(this.text, this.type);

  factory TemplateCreateModel.fromJson(Map<String, dynamic> json) => _$TemplateCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateCreateModelToJson(this);
}
