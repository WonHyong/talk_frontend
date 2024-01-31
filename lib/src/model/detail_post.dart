import 'package:json_annotation/json_annotation.dart';

part 'detail_post.g.dart';

@JsonSerializable()
class DetailPost{
  final String createdDate;
  final String modifiedDate;
  final int id;
  final String title;
  final String content;
  final String writer;
  final int view;
  final List<Comment> comments;
  final List<String> likedMembers;

  DetailPost({
    required this.createdDate,
    required this.modifiedDate,
    required this.id,
    required this.title,
    required this.content,
    required this.writer,
    required this.view,
    required this.comments,
    required this.likedMembers,
  });

  factory DetailPost.fromJson(Map<String, dynamic> json) {
    List<Comment> commentsList = (json['comments'] as List)
        .map((comment) => Comment.fromJson(comment))
        .toList();
    List<String> likedMembersList = (json['likedMembers'] as List)
        .map((member) => member as String)
        .toList();

    return DetailPost(
      createdDate: json['createdDate'],
      modifiedDate: json['modifiedDate'],
      id: json['id'],
      title: json['title'],
      content: json['content'],
      writer: json['writer'],
      view: json['view'],
      comments: commentsList,
      likedMembers: likedMembersList,
    );
  }
}

@JsonSerializable()
class Comment {
  final String createdDate;
  final String modifiedDate;
  final int id;
  final String content;
  final String writer;

  Comment({
    required this.createdDate,
    required this.modifiedDate,
    required this.id,
    required this.content,
    required this.writer,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      createdDate: json['createdDate'],
      modifiedDate: json['modifiedDate'],
      id: json['id'],
      content: json['content'],
      writer: json['writer'],
    );
  }
}
