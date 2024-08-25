import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoiZ29oZXIiLCJhIjoiY20wOGdkaTAwMHBzeTJxcHh3bWl4ZnlzcyJ9.ZfE_D7B6aJgjiwE9OnHpbQ';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline',
      'language': 'es',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken,
    });
    super.onRequest(options, handler);
  }
}
