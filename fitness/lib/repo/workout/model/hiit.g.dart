// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HIIT _$HIITFromJson(Map<String, dynamic> json) {
  return HIIT(
    id: json['id'] as String,
    name: json['name'] as String,
    type: _$enumDecode(_$WorkoutTypeEnumMap, json['type']),
    routines: (json['routines'] as List<dynamic>)
        .map((e) => Routine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HIITToJson(HIIT instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$WorkoutTypeEnumMap[instance.type],
      'routines': instance.routines.map((e) => e.toJson()).toList(),
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
  WorkoutType.CYCLING: 1,
  WorkoutType.HIIT: 2,
};
