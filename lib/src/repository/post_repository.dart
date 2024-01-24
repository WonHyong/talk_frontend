import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/network/post_client.dart';
import 'package:lotalk_frontend/src/network/token_interceptor.dart';

class PostRepository {
  // singleton
  static PostRepository get instance => _instance ??= PostRepository._();
  static PostRepository? _instance;

  late PostClient _client;

  PostRepository._() {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor());
    _client = PostClient(dio);
  }

  Future<PageResponse<Post>> getPosts({int page = 0}) => _client.getPosts(page);
  Future<Post> getPostDetail(int postId) => _client.getPostDetail(postId);
  Future<Post> createPost(Post body) => _client.createPost(body);
  Future<Post> updatePost(int postId, Post body) =>
      _client.updatePost(postId, body);
  Future<HttpResponse> deletePost(int postId) => _client.deletePost(postId);
  Future<HttpResponse> likePost(int postId) => _client.likePost(postId);
}
