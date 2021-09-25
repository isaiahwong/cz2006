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
    intervals: (json['intervals'] as List<dynamic>)
        .map((e) => RoutineInterval.fromJson(e as Map<String, dynamic>))
        .toList(),
    score: json['score'] as int,
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'workout': instance.workout,
      'exercise': instance.exercise.toJson(),
      'score': instance.score,
      'intervals': instance.intervals.map((e) => e.toJson()).toList(),
      'completed': instance.completed,
    };
