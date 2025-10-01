import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_ds.dart';
import '../datasources/task_local_ds.dart';
import '../models/task_dto.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApi remote;
  final TaskLocalDataSource local;
  TaskRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Task>> getTasks({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await local.readTasks();
      if (cached.isNotEmpty) return cached.map((e) => e.toDomain()).toList();
    }
    final remoteList = await remote.getTasks();
    await local.cacheTasks(remoteList);
    return remoteList.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Task> createTask(String title) async {
    final dto = await remote.createTask({"title": title});
    final list = await remote.getTasks();
    await local.cacheTasks(list);
    return dto.toDomain();
  }

  @override
  Future<Task> toggleDone(String id) async {
    final dto = await remote.toggleDone(id);
    final list = await remote.getTasks();
    await local.cacheTasks(list);
    return dto.toDomain();
  }
}
