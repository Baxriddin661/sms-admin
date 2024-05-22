// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateApplicationModel _$CreateApplicationModelFromJson(
        Map<String, dynamic> json) =>
    CreateApplicationModel(
      json['abonentId'] as int?,
      json['type'] as String?,
      (json['templates'] as List<dynamic>?)
          ?.map((e) => TemplateCreateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['applicationId'] as int?,
    );

Map<String, dynamic> _$CreateApplicationModelToJson(
        CreateApplicationModel instance) =>
    <String, dynamic>{
      'abonentId': instance.abonentId,
      'applicationId': instance.applicationId,
      'type': instance.type,
      'templates': instance.templates?.map((e) => e.toJson()).toList(),
    };
