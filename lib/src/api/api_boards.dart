import 'package:dio/dio.dart';
import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:retrofit/http.dart';

part 'api_boards.g.dart';

@RestApi(baseUrl: "http://43.203.90.166:8080/api/boards")
abstract class BoardClient {
  factory BoardClient(Dio dio, {String baseUrl}) = _BoardClient;

  @GET('')
  Future<PageResponse<Post>> getAllPosts(
    @Header("X-AUTH-TOKEN") String token
  );
}