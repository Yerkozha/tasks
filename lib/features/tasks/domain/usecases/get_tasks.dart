import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class GetTasks {
  final TaskRepository _repo;
  GetTasks(this._repo);

  Future<List<Task>> call({bool forceRefresh = false}) =>
      _repo.getTasks(forceRefresh: forceRefresh);
}
// import 'package:injectable/injectable.dart';
// import '../repositories/task_repository.dart';
// import '../entities/task.dart';

// @injectable
// class GetTasks {
//   final TaskRepository repo;
//   GetTasks(this.repo);
//   Future<List<Task>> call() => repo.getAll();
// }


