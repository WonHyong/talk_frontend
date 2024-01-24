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
