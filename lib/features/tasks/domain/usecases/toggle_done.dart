import 'package:injectable/injectable.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class ToggleDone {
  final TaskRepository _repo;
  ToggleDone(this._repo);

  Future<Task> call(String id) => _repo.toggleDone(id);
}