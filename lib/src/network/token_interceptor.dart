import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {

  @override
  Future onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler,
  ) async {
    final jwtToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBRE1JTiIsInJvbGUiOiJBRE1JTiIsImlkIjoiMSIsImlhdCI6MTcwNjAzMTg1OSwiZXhwIjoxNzA2MDM0ODU5fQ.BA9NVzqBvDDVc2QjeYntLxlV6UrUYGYvrZZn-LllU5ul5GzC1qSKObEWXbvrUhDoUghQGsl_WQcnpB-r4-3_Ow";
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