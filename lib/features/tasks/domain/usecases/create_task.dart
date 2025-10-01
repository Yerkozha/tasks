
import '../entities/task.dart';
import '../repositories/task_repository.dart';


class CreateTask {
  final TaskRepository _repo;
  CreateTask(this._repo);
  Future<Task> call(String title) => _repo.createTask(title);
}