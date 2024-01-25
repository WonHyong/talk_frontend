import 'package:json_annotation/json_annotation.dart';

part 'join.g.dart';

@JsonSerializable()
class Join{
  String email;
  String name;
  String password;

  Join({
    required this.email,
    required this.name,
    required this.password});

  factory Join.fromJson(Map<String, dynamic> json) => _$JoinFromJson(json);

  Map<String, dynamic> toJson() => _$JoinToJson(this);
}