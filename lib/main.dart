import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'app/di/di.dart';
import 'features/tasks/presentation/viewmodels/task_list_vm.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/create_task.dart';
import 'features/tasks/domain/usecases/toggle_done.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(ProviderScope(
  overrides: [
    taskListVMProvider.overrideWith(
      (ref) => TaskListVM(sl<GetTasks>(), sl<CreateTask>(), sl<ToggleDone>())..load(),
    ),
  ],
  child: const App(),
));
}