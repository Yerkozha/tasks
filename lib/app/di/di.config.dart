// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_application_1/app/di/modules.dart' as _i13;
import 'package:flutter_application_1/app/di/tasks_injection.dart' as _i14;
import 'package:flutter_application_1/core/network/dio_client.dart' as _i4;
import 'package:flutter_application_1/features/tasks/data/datasources/task_local_ds.dart'
    as _i7;
import 'package:flutter_application_1/features/tasks/data/datasources/task_remote_ds.dart'
    as _i6;
import 'package:flutter_application_1/features/tasks/data/repositories/task_repository_impl.dart'
    as _i9;
import 'package:flutter_application_1/features/tasks/domain/repositories/task_repository.dart'
    as _i8;
import 'package:flutter_application_1/features/tasks/domain/usecases/create_task.dart'
    as _i11;
import 'package:flutter_application_1/features/tasks/domain/usecases/get_tasks.dart'
    as _i12;
import 'package:flutter_application_1/features/tasks/domain/usecases/toggle_done.dart'
    as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    final taskModule = _$TaskModule();
    gh.lazySingleton<_i3.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i4.DioClient>(() => _i4.DioClient());
    await gh.factoryAsync<_i5.SharedPreferences>(
      () => networkModule.prefs(),
      preResolve: true,
    );
    gh.factory<String>(
      () => networkModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.lazySingleton<_i6.TaskApi>(() => taskModule.taskApi(gh<_i3.Dio>()));
    gh.lazySingleton<_i7.TaskLocalDataSource>(
        () => networkModule.taskLocalDataSource(gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i8.TaskRepository>(
        () => _i9.TaskRepositoryImpl(gh<_i7.TaskLocalDataSource>()));
    gh.factory<_i10.ToggleDone>(
        () => _i10.ToggleDone(gh<_i8.TaskRepository>()));
    gh.factory<_i11.CreateTask>(
        () => _i11.CreateTask(gh<_i8.TaskRepository>()));
    gh.factory<_i12.GetTasks>(() => _i12.GetTasks(gh<_i8.TaskRepository>()));
    return this;
  }
}

class _$NetworkModule extends _i13.NetworkModule {}

class _$TaskModule extends _i14.TaskModule {}
