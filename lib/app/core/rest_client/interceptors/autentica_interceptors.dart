import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticaInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 400) {
      // Redireciona usuário
      final sp = await SharedPreferences.getInstance();
      sp.clear();
      handler.next(err);
    } else {
      handler.next(err);
    }
  }
}
