// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineInterval _$RoutineIntervalFromJson(Map<String, dynamic> json) {
  return RoutineInterval(
    id: json['id'] as String,
    iteration: json['iteration'] as int,
    routine: json['routine'] as String,
    currentLog: json['currentLog'] == null
        ? null
        : RoutineLog.fromJson(json['currentLog'] as Map<String, dynamic>),
    type: _$enumDecode(_$RoutineIntervalTypeEnumMap, json['type']),
    defaultWarmups: json['defaultWarmups'] as int,
    defaultSets: json['defaultSets'] as int,
    defaultReps: json['defaultReps'] as int,
    defaultRestDuration: json['defaultRestDuration'] as int,
    logs: (json['logs'] as List<dynamic>)
        .map((e) => RoutineLog.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RoutineIntervalToJson(RoutineInterval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iteration': instance.iteration,
      'routine': instance.routine,
      'currentLog': instance.currentLog.toJson(),
      'logs': instance.logs.map((e) => e.toJson()).toList(),
      'type': _$RoutineIntervalTypeEnumMap[instance.type],
      'defaultWarmups': instance.defaultWarmups,
      'defaultSets': instance.defaultSets,
      'defaultReps': instance.defaultReps,
      'defaultRestDuration': instance.defaultRestDuration,
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

const _$RoutineIntervalTypeEnumMap = {
  RoutineIntervalType.UNKNOWN: 0,
  RoutineIntervalType.WARMUP: 1,
  RoutineIntervalType.SET: 2,
  RoutineIntervalType.DROPSET: 3,
};
