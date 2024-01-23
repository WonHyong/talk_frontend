// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      writer: json['writer'] as String,
      like: json['like'] as int,
      view: json['view'] as int,
      numComment: json['numComment'] as int,
      createdDate: json['createdDate'] as String,
      modifiedDate: json['modifiedDate'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'writer': instance.writer,
      'like': instance.like,
      'view': instance.view,
      'numComment': instance.numComment,
      'createdDate': instance.createdDate,
      'modifiedDate': instance.modifiedDate,
    };
