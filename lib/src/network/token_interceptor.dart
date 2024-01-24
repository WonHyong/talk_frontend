import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const jwtToken =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBRE1JTiIsInJvbGUiOiJBRE1JTiIsImlkIjoiMSIsImlhdCI6MTcwNjA4MzUzMCwiZXhwIjoxNzA2MDg2NTMwfQ.eI-IIeJc4i0RbRJ5QcKHo2Js0hLoa21g54WVJr3FCcwpXszAO0fmpyGk0JwX5yGlnYnuymim3QtvFJDUV9MWlw";
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
