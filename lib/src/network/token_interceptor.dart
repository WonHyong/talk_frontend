import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const jwtToken =
        "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBRE1JTiIsInJvbGUiOiJBRE1JTiIsImlkIjoiMSIsImlhdCI6MTcwNjEwMzQzMSwiZXhwIjoxNzA2MTA2NDMxfQ.dPFGxONB9DUrUp3lRAfTcZ346We5KZgLLQjxTJamB8CedY30oKJjku6EwP1I62ZqrBevb1EYSR0d227MWHQL_g";
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
