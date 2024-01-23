import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';

part 'post_client.g.dart';

@RestApi()
abstract class PostClient {
  factory PostClient(Dio dio, {String baseUrl}) = _PostClient;

  @GET('')
  Future<PageResponse<Post>> getPosts(@Query('page') int page);

  @GET('/{postId}')
  Future<Post> getPostDetail(@Path() int postId);

  @POST('')
  Future<Post> createPost(@Body() Post body);

  @PUT('/{postId}')
  Future<Post> updatePost(@Path() int postId, @Body() Post body);

  @DELETE('/{postId}')
  Future<HttpResponse> deletePost(@Path() int postId);

  @POST('/{postId}')
  Future<HttpResponse> likePost(@Path() int postId);
}