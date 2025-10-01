import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task_dto.dart';

part 'task_local_ds.isar.dart';

class TaskLocalDataSource {
  static Isar? _isar;

  static Future<Isar> _db() async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      /* schemas here, e.g., TaskSchema */
    ], directory: dir.path);
    return _isar!;
  }

  Future<void> cacheTasks(List<TaskDto> tasks) async {
    final isar = await _db();
    await isar.writeTxn(() async {
      // upsert tasks (use Isar collection). Pseudocode below.
      // await isar.tasks.putAll(tasks.map((e) => e.toIsar()).toList());
    });
  }

  Future<List<TaskDto>> readTasks() async {
    final isar = await _db();
    // return (await isar.tasks.where().findAll()).map((it) => it.toDto()).toList();
    return [];
  }
}
