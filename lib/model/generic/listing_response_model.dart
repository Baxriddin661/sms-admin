

import 'package:json_annotation/json_annotation.dart';

part 'listing_response_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  genericArgumentFactories: true,
)
class ListingResponseModel<T> {
  //example json
  /*
  {
    "content": [],
    "pageable": {
      "sort": {
        "unsorted": true,
        "sorted": false,
        "empty": true
      },
      "pageNumber": 0,
      "pageSize": 45,
      "offset": 0,
      "unpaged": false,
      "paged": true
    },
    "totalPages": 0,
    "totalElements": 0,
    "last": true,
    "numberOfElements": 0,
    "first": true,
    "size": 45,
    "number": 0,
    "sort": {
      "unsorted": true,
      "sorted": false,
      "empty": true
    },
    "empty": true
  }
   */

  //fields
  final List<T> content;
  final int totalPages;
  @JsonKey(name: 'number')
  final int currentPage;
  final int size;

  ListingResponseModel(this.content, this.totalPages, this.currentPage, this.size);

  factory ListingResponseModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListingResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ListingResponseModelToJson(this, toJsonT);
}
