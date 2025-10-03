import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task_dto.dart';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kTasksKey = 'tasks_json_list';

// @lazySingleton
class TaskLocalDataSource {

  final SharedPreferences _prefs;
  TaskLocalDataSource(this._prefs);

  Future<List<TaskDto>> readAll() async {
    final raw = _prefs.getString(_kTasksKey);
    if (raw == null) return const [];
    final list = (jsonDecode(raw) as List)
        .map((e) => TaskDto.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }

  Future<void> writeAll(List<TaskDto> tasks) async {
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await _prefs.setString(_kTasksKey, jsonEncode(jsonList));
  }


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