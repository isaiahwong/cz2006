// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineLog _$RoutineLogFromJson(Map<String, dynamic> json) {
  return RoutineLog(
    id: json['id'] as String,
    reps: json['reps'] as int,
    interval:
        RoutineInterval.fromJson(json['interval'] as Map<String, dynamic>),
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$RoutineLogToJson(RoutineLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reps': instance.reps,
      'interval': instance.interval,
      'completed': instance.completed,
    };
