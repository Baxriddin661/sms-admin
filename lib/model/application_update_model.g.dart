// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationUpdateModel _$ApplicationUpdateModelFromJson(
        Map<String, dynamic> json) =>
    ApplicationUpdateModel(
      id: json['id'] as int,
      status: json['status'] as String,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$ApplicationUpdateModelToJson(
        ApplicationUpdateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'comment': instance.comment,
    };
