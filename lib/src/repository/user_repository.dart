import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import 'package:lotalk_frontend/src/network/user_client.dart';
import 'package:lotalk_frontend/src/preferences.dart';
import 'package:lotalk_frontend/src/repository/base_repository.dart';
import 'package:retrofit/dio.dart';

import '../model/login.dart';
import '../model/token.dart';
import '../model/join.dart';

class UserRepository implements BaseRepository {
  // singleton
  static UserRepository get instance =>
      _instance ??= _instance = UserRepository._();
  static UserRepository? _instance;

  late UserClient _client;
  late CookieJar _cookieJar;

  UserRepository._() {
    final dio = Dio();
    _client = UserClient(dio);
    _cookieJar = CookieJar(ignoreExpires: true);
  }

  Future<Token> login(Login request) => _client.login(request);

  Future<HttpResponse> join(Join request) => _client.join(request);

  Future<Token> refresh() async {
    _cookieJar.loadForRequest(Uri.parse('/')).then((cookies) {
      String username = SharedPrefs().username;
      String refreshToken = _getRefreshToken(cookies);
      return _client.refresh(username, refreshToken);
    });
    throw Error();
  }

  String _getRefreshToken(List<Cookie> cookies) {
    return cookies.firstWhere((cookie) => cookie.name == 'refreshtoken').value;
  }
}
