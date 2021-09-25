// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    id: json['id'] as String,
    name: json['name'] as String,
    defaultWarmups: json['default_warmups'] as int,
    defaultSets: json['default_sets'] as int,
    defaultReps: json['default_reps'] as int,
    defaultRestDuration: json['default_rest_duration'] as int,
    // next: json['next'] == null
    //     ? null
    //     : Exercise.fromJson(json['next'] as Map<String, dynamic>) ?? '',
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'default_warmups': instance.defaultWarmups,
      'default_sets': instance.defaultSets,
      'default_reps': instance.defaultReps,
      'default_rest_duration': instance.defaultRestDuration,
    };
