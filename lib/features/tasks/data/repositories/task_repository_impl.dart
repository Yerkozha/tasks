import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_ds.dart';
import '../datasources/task_local_ds.dart';
import '../models/task_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _local;
  TaskRepositoryImpl(this._local);

  @override
  Future<List<Task>> getTasks({bool forceRefresh = false}) async {
    final dtos = await _local.readAll();
    return dtos.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Task> createTask(String title) async {
    final list = await _local.readAll();
    final now = DateTime.now();
    final dto = TaskDto(
      id: now.microsecondsSinceEpoch.toString(),
      title: title.trim(),
      done: false,
      updatedAt: now,
    );
    final updated = [...list, dto];
    await _local.writeAll(updated);
    return dto.toDomain();
  }

  @override
  Future<Task> toggleDone(String id) async {
    final list = await _local.readAll();
    final updated = list.map((e) {
      if (e.id == id) {
        return e.copyWith(done: !e.done, updatedAt: DateTime.now());
      }
      return e;
    }).toList();
    await _local.writeAll(updated);
    return updated.firstWhere((e) => e.id == id).toDomain();
  }
}


// class TaskRepositoryImpl implements TaskRepository {
//   final TaskApi remote;
//   final TaskLocalDataSource local;
//   TaskRepositoryImpl({required this.remote, required this.local});

//   @override
//   Future<List<Task>> getTasks({bool forceRefresh = false}) async {
//     if (!forceRefresh) {
//       final cached = await local.readTasks();
//       if (cached.isNotEmpty) return cached.map((e) => e.toDomain()).toList();
//     }
//     final remoteList = await remote.getTasks();
//     await local.cacheTasks(remoteList);
//     return remoteList.map((e) => e.toDomain()).toList();
//   }

//   @override
//   Future<Task> createTask(String title) async {
//     final dto = await remote.createTask(TaskDto(id: 'tmp', title: title, done: false));
//     final list = await remote.getTasks();
//     await local.cacheTasks(list);
//     return dto.toDomain();
//   }

//   @override
//   Future<Task> toggleDone(String id) async {
//     final dto = await remote.toggleDone(id);
//     final list = await remote.getTasks();
//     await local.cacheTasks(list);
//     return dto.toDomain();
//   }
// }
