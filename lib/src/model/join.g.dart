// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Join _$JoinFromJson(Map<String, dynamic> json) => Join(
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$JoinToJson(Join instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
    };
