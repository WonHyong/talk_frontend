import 'package:dio/dio.dart';

import 'package:lotalk_frontend/src/network/user_client.dart';
import 'package:lotalk_frontend/src/repository/base_repository.dart';

import '../model/login.dart';
import '../model/token.dart';

class UserRepository implements BaseRepository {
  // singleton
  static UserRepository get instance =>
      _instance ??= _instance = UserRepository._();
  static UserRepository? _instance;

  late UserClient _client;

  UserRepository._() {
    final dio = Dio();
    _client = UserClient(dio);
  }

  Future<Token> login(Login request) => _client.login(request);
}
