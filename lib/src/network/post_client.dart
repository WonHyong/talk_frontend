import 'package:dio/dio.dart';
import 'package:lotalk_frontend/src/model/create_post.dart';
import 'package:lotalk_frontend/src/model/detail_post.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';

import '../model/create_comment.dart';

part 'post_client.g.dart';

@RestApi(baseUrl: "http://43.203.90.166:8080/api/boards")
abstract class PostClient {
  factory PostClient(Dio dio, {String baseUrl}) = _PostClient;

  @GET('')
  Future<PageResponse<Post>> getPosts(@Query('page') int page);

  @GET('/{postId}')
  Future<DetailPost> getPostDetail(@Path() int postId);

  @POST('')
  Future<HttpResponse> createPost(@Body() CreatePost body);

  @PUT('/{postId}')
  Future<HttpResponse> updatePost(@Path() int postId, @Body() CreatePost body);

  @DELETE('/{postId}')
  Future<HttpResponse> deletePost(@Path() int postId);

  @POST('/{postId}')
  Future<HttpResponse> likePost(@Path() int postId);

  @POST('/{postId}/comments')
  Future<HttpResponse> createComment(@Path() int postId, @Body() CreateComment body);
}