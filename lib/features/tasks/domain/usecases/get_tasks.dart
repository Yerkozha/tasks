import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasks {
  final TaskRepository _repo;
  GetTasks(this._repo);
  Future<List<Task>> call({bool forceRefresh = false}) =>
  _repo.getTasks(forceRefresh: forceRefresh);
}

