import 'package:json_annotation/json_annotation.dart';

part 'create_post.g.dart';

@JsonSerializable()
class CreatePost{
  String title;
  String content;

  CreatePost({
    required this.title,
    required this.content});

  factory CreatePost.fromJson(Map<String, dynamic> json) => _$CreatePostFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePostToJson(this);
}