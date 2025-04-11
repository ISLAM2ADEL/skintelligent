import 'package:dio/dio.dart';

class ApiInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    Map<String, String> headers = {
      // ApiKey.token: token != null ? 'FOODAPI $token' : 'Error in token',
      "Content-Type": "application/json",
    };

    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }
}
