// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    id: json['id'] as String,
    start: Coordinates.fromJson(json['start'] as Map<String, dynamic>),
    end: Coordinates.fromJson(json['end'] as Map<String, dynamic>),
    coordinates:
        Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'start': instance.start.toJson(),
      'end': instance.end.toJson(),
      'coordinates': instance.coordinates.toJson(),
    };
