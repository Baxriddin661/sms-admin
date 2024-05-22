/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
import 'package:json_annotation/json_annotation.dart';

part 'application_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplicationModel {

    //example json
  /*
  {
            "id": 11,
            "createdAt": "26-04-2024 10:20:35",
            "updatedAt": "26-04-2024 10:20:52",
            "abonentId": 76,
            "comment": null,
            "status": "SENT",
            "type": "ADDING_TEMPLATE"
        }
   */

    //fields
  final int id;
  final String? createdAt;
  final int? abonentId;
  final String? comment;
  final String? status;
  final String? type;

  ApplicationModel(this.id, this.createdAt, this.abonentId, this.comment, this.status, this.type);

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
