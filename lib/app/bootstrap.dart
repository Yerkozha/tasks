import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import '../features/tasks/presentation/viewmodels/task_list_vm.dart';
import '../features/tasks/domain/usecases/get_tasks.dart';
import '../features/tasks/domain/usecases/create_task.dart';
import 'di/di.dart';
import 'package:flutter/widgets.dart';

Future<List<Override>> bootstrap() async {
  await configureDependencies();

  final getTasks = sl<GetTasks>();
  final createTask = sl<CreateTask>();

  return [
    // Riverpod v3 uses (Ref ref) => instance
    taskListVMProvider.overrideWith((ref) => TaskListVM(getTasks, createTask)),
  ];
}