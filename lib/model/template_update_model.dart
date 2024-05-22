/**
 * Created by Baxriddin Baxrom on 16/05/24.
 * Project sms_etc_admin
 */

import 'package:json_annotation/json_annotation.dart';



part 'template_update_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemplateUpdateModel {

  final int id;

  final String status;

  TemplateUpdateModel({required this.id, required this.status});

  factory TemplateUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateUpdateModelToJson(this);
}
