// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Routine _$RoutineFromJson(Map<String, dynamic> json) {
  return Routine(
    id: json['id'] as String,
    exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
    workout: json['workout'] as String,
    defaultWarmups: json['defaultWarmups'] as int,
    defaultSets: json['defaultSets'] as int,
    defaultReps: json['defaultReps'] as int,
    score: json['score'] as int,
    completed: json['completed'] as bool,
    defaultRestDuration: json['defaultRestDuration'] as int,
  );
}

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'workout': instance.workout,
      'exercise': instance.exercise,
      'defaultWarmups': instance.defaultWarmups,
      'defaultSets': instance.defaultSets,
      'score': instance.score,
      'defaultReps': instance.defaultReps,
      'defaultRestDuration': instance.defaultRestDuration,
      'completed': instance.completed,
    };
