import 'package:dio/dio.dart';
import 'package:lotalk_frontend/src/model/token.dart';

class TokenInterceptor extends Interceptor {
  static Token? token = null;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String accessToken = token!.accessToken;
    options.headers['X-AUTH-TOKEN'] = accessToken;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized
    // TODO: refresh token
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
