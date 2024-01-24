import 'package:dio/dio.dart';
import 'dart:html';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final jwtToken = window.localStorage['jwt_access'];
    options.headers['X-AUTH-TOKEN'] = jwtToken;
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized
    // TODO: refresh token
    if (err.response?.statusCode == 401) {
      print("INVALID TOKEN ERROR");
    }
    super.onError(err, handler);
  }
}
