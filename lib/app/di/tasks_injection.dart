import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../../features/tasks/data/datasources/task_remote_ds.dart';
import '../../features/tasks/data/datasources/task_local_ds.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/get_tasks.dart';
import '../../features/tasks/domain/usecases/create_task.dart';

@module
abstract class TaskModule {
  @lazySingleton
  TaskApi taskApi(Dio dio) => TaskApi(
    dio,
    baseUrl: const String.fromEnvironment(
      'API_URL',
      defaultValue: 'https://api.example.com',
    ),
  );

  @lazySingleton
  TaskLocalDataSource get local => TaskLocalDataSource();
}

@LazySingleton(as: TaskRepository)
class TaskRepositoryProvider extends TaskRepositoryImpl {
  TaskRepositoryProvider({required super.remote, required super.local});
}

@injectable
GetTasks provideGetTasks(TaskRepository repo) => GetTasks(repo);

@injectable
CreateTask provideCreateTask(TaskRepository repo) => CreateTask(repo);
