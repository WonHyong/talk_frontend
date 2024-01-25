// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      name: json['name'] as String,
      accessToken: json['accessToken'] as String,
      expiration: json['expiration'] as String,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'name': instance.name,
      'accessToken': instance.accessToken,
      'expiration': instance.expiration,
    };
