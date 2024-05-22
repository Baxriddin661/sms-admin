// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    ApplicationModel(
      json['id'] as int,
      json['createdAt'] as String?,
      json['abonentId'] as int?,
      json['comment'] as String?,
      json['status'] as String?,
      json['type'] as String?,
    );

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'abonentId': instance.abonentId,
      'comment': instance.comment,
      'status': instance.status,
      'type': instance.type,
    };
