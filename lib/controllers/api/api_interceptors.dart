import 'package:dio/dio.dart';

import '../../services/service_locator.dart';
import '../cache/cache_helper.dart';
import 'endpoint.dart';

class ApiInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    Map<String, String> headers = {
      // ApiKey.token: token != null ? 'FOODAPI $token' : 'Error in token',
      "Content-Type": "application/json",
      ApiKey.Authorization: 'Bearer ${getIt<CacheHelper>().getData(key: ApiKey.Authorization,)}',
    };

    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }
}
