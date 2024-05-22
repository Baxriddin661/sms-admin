// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingResponseModel<T> _$ListingResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListingResponseModel<T>(
      (json['content'] as List<dynamic>).map(fromJsonT).toList(),
      json['totalPages'] as int,
      json['number'] as int,
      json['size'] as int,
    );

Map<String, dynamic> _$ListingResponseModelToJson<T>(
  ListingResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content.map(toJsonT).toList(),
      'totalPages': instance.totalPages,
      'number': instance.currentPage,
      'size': instance.size,
    };
