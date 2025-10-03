// import 'package:injectable/injectable.dart';
// import './task_repository.dart';
// import 'package:flutter_application_1/features/tasks/domain/entities/task.dart';
// import 'package:flutter_application_1/features/tasks/data/datasources/task_remote_ds.dart';
// import 'package:flutter_application_1/features/tasks/data/models/task_dto.dart';

// @LazySingleton(as: TaskRepository)
// class TaskRepositoryImpl implements TaskRepository {
//   final TaskApi api;
//   TaskRepositoryImpl(this.api);

//   @override
//   Future<List<Task>> getTasks({bool forceRefresh = false}) async {
//     final dtos = await api.getTasks();
//     return dtos.map((d) => d.toDomain()).toList();
//   }

//   @override
//   Future<Task> createTask(String title) async {
//     final created = await api.createTask(TaskDto(id: 'tmp', title: title, done: false));
//     return created.toDomain();
//   }

//   @override
//   Future<Task> toggleDone(String id) async {
//     final dto = await api.toggleDone(id);
//     return dto.toDomain();
//   }
// }
