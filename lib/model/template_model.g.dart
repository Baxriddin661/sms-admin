// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateModel _$TemplateModelFromJson(Map<String, dynamic> json) =>
    TemplateModel(
      json['id'] as int,
      json['text'] as String,
      json['status'] as String,
      json['type'] as String,
      json['abonentId'] as int,
      json['applicationId'] as int,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$TemplateModelToJson(TemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'status': instance.status,
      'type': instance.type,
      'abonentId': instance.abonentId,
      'applicationId': instance.applicationId,
      'createdAt': instance.createdAt,
    };
