import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {

  @override
  Future onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler,
  ) async {
    final jwtToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBRE1JTiIsInJvbGUiOiJBRE1JTiIsImlkIjoiMSIsImlhdCI6MTcwNjAyNjg3MSwiZXhwIjoxNzA2MDI5ODcxfQ.EbODCvNDjWezuovStpACZ7AtJZA-HcD9hG1q4Sa1ijGJrmODbGIsOuwQ56N81IeaHH5gY9TMKN_mszM54ThcgA";
    options.headers['X-AUTH-TOKEN'] = jwtToken;
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {
      print("INVALID TOKEN ERROR");
    }
    super.onError(err, handler);
  }
}