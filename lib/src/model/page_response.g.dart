// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse<T> _$PageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PageResponse<T>(
      content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
      size: json['size'] as int,
      number: json['number'] as int,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$PageResponseToJson<T>(
  PageResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'content': instance.content.map(toJsonT).toList(),
      'size': instance.size,
      'number': instance.number,
      'last': instance.last,
    };
