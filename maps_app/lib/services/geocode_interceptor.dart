import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoiZ29oZXIiLCJhIjoiY20wOGdkaTAwMHBzeTJxcHh3bWl4ZnlzcyJ9.ZfE_D7B6aJgjiwE9OnHpbQ';

class GeocodeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      "limit": "7",
      "language": "es",
      "access_token": accessToken,
    });
    super.onRequest(options, handler);
  }
}
