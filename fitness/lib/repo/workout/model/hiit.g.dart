// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HIIT _$HIITFromJson(Map<String, dynamic> json) {
  return HIIT(
    id: json['id'] as String,
    name: json['name'] as String,
    routines: (json['routines'] as List<dynamic>)
        .map((e) => Routine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HIITToJson(HIIT instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'routines': instance.routines.map((e) => e.toJson()).toList(),
    };
