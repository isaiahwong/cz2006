// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    id: json['id'] as String,
    name: json['name'] as String,
    defaultWarmups: json['defaultWarmups'] as int,
    defaultSets: json['defaultSets'] as int,
    defaultReps: json['defaultReps'] as int,
    defaultRestDuration: json['defaultRestDuration'] as int,
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'defaultWarmups': instance.defaultWarmups,
      'defaultSets': instance.defaultSets,
      'defaultReps': instance.defaultReps,
      'defaultRestDuration': instance.defaultRestDuration,
    };
