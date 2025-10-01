import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  Dio build() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),

      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: false),
    );
    return dio;
  }
}
