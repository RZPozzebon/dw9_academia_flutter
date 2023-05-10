import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dw9_delivery_app/app/core/rest_client/interceptors/autentica_interceptors.dart';

import '../config/env/env.dart';

class CustomDio extends DioForNative {
  // Atributos

  late AutenticaInterceptors _autenticaInterceptors;

  // Construtor
  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.i['backend_base_url']!,
          connectTimeout: 5000,
          receiveTimeout: 60000,
        )) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
    _autenticaInterceptors = AutenticaInterceptors();
  }

  CustomDio auth() {
    interceptors.add(_autenticaInterceptors);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_autenticaInterceptors);
    return this;
  }
}
