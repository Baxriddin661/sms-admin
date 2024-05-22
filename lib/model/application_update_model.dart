import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Baxriddin Baxrom on 16/05/24.
 * Project sms_etc_admin
 */


//
// {
// "id": 0,
// "status": "ACCEPTED",
// "comment": "string"
// }


part 'application_update_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplicationUpdateModel {

  final int id;
  final String status;
  final String comment;


  ApplicationUpdateModel(
      {required this.id, required this.status, required this.comment});

  factory ApplicationUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationUpdateModelToJson(this);


}