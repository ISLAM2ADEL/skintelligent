import 'package:dio/dio.dart';
import 'package:skintelligent/commons.dart';

class ApiInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await getIt<CacheHelper>().getData(key: ApiKey.token);

    Map<String, String> headers = {
      ApiKey.token: token != null ? 'FOODAPI $token' : 'Error in token',
    };

    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }
}
