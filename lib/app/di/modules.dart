import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../core/network/dio_client.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  Dio dio(DioClient client) => client.build();
}
