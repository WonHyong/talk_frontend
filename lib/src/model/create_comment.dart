import 'package:json_annotation/json_annotation.dart';

part 'create_comment.g.dart';

@JsonSerializable()
class CreateComment{
  String content;

  CreateComment({
    required this.content});

  factory CreateComment.fromJson(Map<String, dynamic> json) => _$CreateCommentFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentToJson(this);
}