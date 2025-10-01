import 'package:freezed_annotation/freezed_annotation.dart';
part 'task.freezed.dart';

// part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    @Default(false) bool done,
    DateTime? updatedAt,
  }) = _Task;
}
