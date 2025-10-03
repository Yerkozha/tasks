import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class CreateTask {
  final TaskRepository _repo;
  CreateTask(this._repo);

  Future<Task> call(String title) => _repo.createTask(title);
}


// import 'package:injectable/injectable.dart';
// import '../repositories/task_repository.dart';
// import '../entities/task.dart';

// @injectable
// class CreateTask {
//   final TaskRepository repo;
//   CreateTask(this.repo);
//   Future<void> call(Task t) => repo.create(t);
// }