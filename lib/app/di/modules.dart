// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import '../../core/network/dio_client.dart';

// @module
// abstract class RegisterModule {
//   @lazySingleton
//   Logger get logger => Logger();

//   @lazySingleton
//   Dio dio(DioClient client) => client.build();
// }


import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';




// ⬇️ adjust the import path to wherever your TaskApi abstract class lives
import 'package:flutter_application_1/features/tasks/data/datasources/task_local_ds.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
        ),
      );

  // Keep baseUrl in DI so Retrofit client can get it
  @Named('baseUrl')
  String get baseUrl => 'https://api.example.com'; // TODO: replace
  
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @lazySingleton
  TaskLocalDataSource taskLocalDataSource(SharedPreferences prefs) =>
      TaskLocalDataSource(prefs);
}



// @module
// abstract class ApiModule {
//   // Retrofit TaskApi depends on Dio (+ optional baseUrl)
//   @lazySingleton
//   TaskApi taskApi(Dio dio, @Named('baseUrl') String baseUrl) =>
//       TaskApi(dio, baseUrl: baseUrl);
// }
