import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  int id;
  String title;
  String writer;
  int like;
  int view;
  int numComment;
  String createdDate, modifiedDate;

  Post({required this.id, 
  required this.title, 
  required this.writer, 
  required this.like, 
  required this.view, 
  required this.numComment,
  required this.createdDate,
  required this.modifiedDate});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  

  Map<String, dynamic> toJson() => _$PostToJson(this); 
}