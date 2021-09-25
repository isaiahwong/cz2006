// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineInterval _$RoutineIntervalFromJson(Map<String, dynamic> json) {
  return RoutineInterval(
    id: json['id'] as String,
    iteration: json['iteration'] as int,
    routine: Routine.fromJson(json['routine'] as Map<String, dynamic>),
    currentLog: RoutineLog.fromJson(json['currentLog'] as Map<String, dynamic>),
    type: _$enumDecode(_$RoutineIntervalTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$RoutineIntervalToJson(RoutineInterval instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iteration': instance.iteration,
      'routine': instance.routine,
      'currentLog': instance.currentLog,
      'type': _$RoutineIntervalTypeEnumMap[instance.type],
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
  RoutineIntervalType.WARMUP: 'Warmup',
  RoutineIntervalType.SET: 'Set',
  RoutineIntervalType.DROPSET: 'Dropset',
};
