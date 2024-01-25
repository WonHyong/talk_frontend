import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';

import '../model/login.dart';
import '../model/token.dart';
import '../model/join.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: "http://43.203.90.166:8080/api/members")
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @POST('/login')
  Future<Token> login(@Body() Login request);

  @POST('/new')
  Future<HttpResponse> join(@Body() Join request);

  @POST('/auth/refresh')
  Future<Token> refresh(String username, String refreshToken);
}
