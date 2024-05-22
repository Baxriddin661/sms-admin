/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
import 'package:json_annotation/json_annotation.dart';

part 'template_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemplateModel {

    //example json
  /*
  {
            "id": 4,
            "text": "text00hw2324wq23o 3223312322",
            "status": "ACTIVE",
            "type": "SERVICE",
            "abonentId": 76,
            "applicationId": 3,
            "createdAt": "28-03-2024 09:38:31",
            "updatedAt": "03-04-2024 11:20:34"
        }
   */

    //fields
  final int id;
  final String text;
  final String status;
  final String type;
  final int abonentId;
  final int applicationId;
  final String createdAt;

  TemplateModel(this.id, this.text, this.status, this.type, this.abonentId, this.applicationId, this.createdAt);

  factory TemplateModel.fromJson(Map<String, dynamic> json) => _$TemplateModelFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateModelToJson(this);
}
