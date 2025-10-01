import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';
part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
class TaskDto with _$TaskDto {
  const factory TaskDto({
    required String id,
    required String title,
    required bool done,
    DateTime? updatedAt,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
}

extension TaskDtoX on TaskDto {
  Task toDomain() =>
      Task(id: id, title: title, done: done, updatedAt: updatedAt);

  static TaskDto fromDomain(Task t) =>
      TaskDto(id: t.id, title: t.title, done: t.done, updatedAt: t.updatedAt);
}
