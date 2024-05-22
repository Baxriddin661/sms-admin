import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  //example json
  /*
  {
    "id": 76,
    "login": "akmal",
    "name": "akmaltest",
    "emailAddress": "akmal@etc.uz",
    "roleId": 2,
    "role": "ROLE_USER"
}
   */

  //fields
  final int? id;
  final String? login;
  final String? name;
  final String? emailAddress;
  final String? role;
  final int? roleId;

  UserModel(this.id, this.login, this.name, this.emailAddress, this.role, this.roleId);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
