// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => _TaskDto(
  id: json['id'] as String,
  title: json['title'] as String,
  done: json['done'] as bool,
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaskDtoToJson(_TaskDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'done': instance.done,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
