import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks({bool forceRefresh = false});
  Future<Task> createTask(String title);
  Future<Task> toggleDone(String id);
}
