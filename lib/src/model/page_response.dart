
import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageResponse<T> {
  List<T> content;
  int size;
  int number;
  bool last;

  PageResponse({
    required this.content,
    required this.size,
    required this.number,
    required this.last
  });

  factory PageResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) 
    => _$PageResponseFromJson(json, fromJsonT);
}