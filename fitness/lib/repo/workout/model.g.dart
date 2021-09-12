// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    id: json['id'] as String,
    name: json['name'] as String,
    type: _$enumDecode(_$WorkoutTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$WorkoutTypeEnumMap[instance.type],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$WorkoutTypeEnumMap = {
  WorkoutType.CYCLING: 'cycling',
  WorkoutType.HIIT: 'HIIT',
};

Routine _$RoutineFromJson(Map<String, dynamic> json) {
  return Routine(
    id: json['id'] as String,
    exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
    workout: json['workout'] as String,
    defaultWarmups: json['defaultWarmups'] as int,
    defaultSets: json['defaultSets'] as int,
    defaultReps: json['defaultReps'] as int,
    defaultRestDuration: json['defaultRestDuration'] as int,
  );
}

Map<String, dynamic> _$RoutineToJson(Routine instance) => <String, dynamic>{
      'id': instance.id,
      'workout': instance.workout,
      'exercise': instance.exercise,
      'defaultWarmups': instance.defaultWarmups,
      'defaultSets': instance.defaultSets,
      'defaultReps': instance.defaultReps,
      'defaultRestDuration': instance.defaultRestDuration,
    };
