import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  String? accessToken;

  void setAccessToken(String? token){
    accessToken = token;
  }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-AUTH-TOKEN'] = accessToken;
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
