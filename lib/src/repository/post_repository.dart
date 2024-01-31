import 'package:dio/dio.dart';
import 'package:lotalk_frontend/src/model/create_comment.dart';
import 'package:lotalk_frontend/src/model/detail_post.dart';
import 'package:lotalk_frontend/src/repository/base_repository.dart';
import 'package:retrofit/retrofit.dart';

import 'package:lotalk_frontend/src/model/page_response.dart';
import 'package:lotalk_frontend/src/model/post.dart';
import 'package:lotalk_frontend/src/network/post_client.dart';
import 'package:lotalk_frontend/src/network/token_interceptor.dart';

import '../model/create_post.dart';

class PostRepository implements BaseRepository {
  // singleton
  static PostRepository get instance =>
      _instance ??= _instance = PostRepository._();
  static PostRepository? _instance;

  late PostClient _client;

  PostRepository._() {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor());
    _client = PostClient(dio);
  }

  Future<PageResponse<Post>> getPosts({int page = 0}) => _client.getPosts(page);
  Future<DetailPost> getPostDetail(int postId) => _client.getPostDetail(postId);
  Future<HttpResponse> createPost(CreatePost body) => _client.createPost(body);
  Future<HttpResponse> updatePost(int postId, CreatePost body) =>
      _client.updatePost(postId, body);
  Future<HttpResponse> deletePost(int postId) => _client.deletePost(postId);
  Future<HttpResponse> likePost(int postId) => _client.likePost(postId);
  Future<HttpResponse> createComment(int postId, CreateComment body) =>
      _client.createComment(postId, body);
}
