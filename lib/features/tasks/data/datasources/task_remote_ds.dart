import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/task_dto.dart';
part 'task_remote_ds.g.dart';

@RestApi()
abstract class TaskApi {
  factory TaskApi(Dio dio, {String baseUrl}) = _TaskApi;

  @GET('/tasks')
  Future<List<TaskDto>> getTasks();

  @POST('/tasks')
  Future<TaskDto> createTask(@Body() TaskDto body);

  @PATCH('/tasks/{id}/toggle')
  Future<TaskDto> toggleDone(@Path('id') String id);
}
