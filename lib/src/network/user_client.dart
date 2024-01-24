import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/login.dart';
import '../model/token.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: "http://43.203.90.166:8080/api/members")
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  @POST('/login')
  Future<Token> login(@Body() Login request);
}
