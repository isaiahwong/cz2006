// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  return Coordinates(
    name: json['name'] as String,
    x: (json['x'] as num).toDouble(),
    y: (json['y'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
    };
