/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponseModel {

    //example json
  /*
  {
    "id": 76,
    "login": "akmal",
    "name": "akmaltest",
    "emailAddress": "akmal@etc.uz",
    "roleId": 2,
    "role": "ROLE_USER",
    "accessToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJha21hbCIsImlhdCI6MTcxNDk5MDY2NiwiZXhwIjoxNzE1MDc3MDY2LCJpc3MiOiJBa29iaXIgQWJkdWdhbmlldiIsInJvbGUiOiJST0xFX1VTRVIifQ.LvADu0vmo6cISjaR8qEWPl_xQN7dkJoHqQTOPwzPgxw"
}
   */

    //fields
  final String accessToken;

  LoginResponseModel(this.accessToken);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
