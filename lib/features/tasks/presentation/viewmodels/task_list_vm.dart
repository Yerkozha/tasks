import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/toggle_done.dart';

class TaskListState {
  final List<Task> items;
  final bool loading;
  final String? error;
  const TaskListState({
    this.items = const [],
    this.loading = false,
    this.error,
  });

  TaskListState copyWith({List<Task>? items, bool? loading, String? error}) =>
      TaskListState(
        items: items ?? this.items,
        loading: loading ?? this.loading,
        error: error,
      );
}

class TaskListVM extends StateNotifier<TaskListState> {
  final GetTasks _getTasks;
  final CreateTask _createTask;
  final ToggleDone _toggleDone;

  TaskListVM(this._getTasks, this._createTask, this._toggleDone) : super(const TaskListState());

  Future<void> load({bool refresh = false}) async {
    try {
      state = state.copyWith(loading: true, error: null);
      final list = await _getTasks(forceRefresh: refresh);
      state = state.copyWith(items: list, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> toggle(String id) async {
    try {
      final updated = await _toggleDone(id);
      final list =
          state.items.map((t) => t.id == updated.id ? updated : t).toList();
      state = state.copyWith(items: list);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> add(String title) async {
    try {
      state = state.copyWith(loading: true);
      final _ = await _createTask(title);
      await load(refresh: true);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final taskListVMProvider = StateNotifierProvider<TaskListVM, TaskListState>((
  ref,
) {
  throw UnimplementedError('Provided via DI in bootstrap');
});
