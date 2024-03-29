// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return Workout(
    id: json['id'] as String,
    name: json['name'] as String,
    host: json['host'] as String? ?? '',
    participants: (json['participants'] as List<dynamic>?)
            ?.map((e) => UserSnippet.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    type: _$enumDecode(_$WorkoutTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'host': instance.host,
      'type': _$WorkoutTypeEnumMap[instance.type],
      'participants': instance.participants.map((e) => e.toJson()).toList(),
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
  WorkoutType.UNKNOWN: 0,
  WorkoutType.CYCLING: 1,
  WorkoutType.HIIT: 2,
};
