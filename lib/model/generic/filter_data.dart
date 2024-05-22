import 'package:json_annotation/json_annotation.dart';


part 'filter_data.g.dart';

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
)
class FilterData {
  int? page;
  int? size;
  int? applicationId;
  String? search;
  String? status;


  FilterData(this.page, this.size);

  FilterData.defaultListing({this.page = 1, this.size = 20});

  factory FilterData.fromJson(Map<String, dynamic> json) =>
      _$FilterDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
