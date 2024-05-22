// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['id'] as int?,
      json['login'] as String?,
      json['name'] as String?,
      json['emailAddress'] as String?,
      json['role'] as String?,
      json['roleId'] as int?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'name': instance.name,
      'emailAddress': instance.emailAddress,
      'role': instance.role,
      'roleId': instance.roleId,
    };
