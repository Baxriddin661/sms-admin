// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterData _$FilterDataFromJson(Map<String, dynamic> json) => FilterData(
      json['page'] as int?,
      json['size'] as int?,
    )
      ..applicationId = json['applicationId'] as int?
      ..search = json['search'] as String?
      ..status = json['status'] as String?;

Map<String, dynamic> _$FilterDataToJson(FilterData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('size', instance.size);
  writeNotNull('applicationId', instance.applicationId);
  writeNotNull('search', instance.search);
  writeNotNull('status', instance.status);
  return val;
}
