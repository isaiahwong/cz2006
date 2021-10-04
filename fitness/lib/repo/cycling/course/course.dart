import 'package:fitness/common/common.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable(explicitToJson: true)
class Course {
  String id;
  final Coordinates start;
  final Coordinates end;
  final Coordinates coordinates;

  Course({
    this.id = '',
    required this.start,
    required this.end,
    required this.coordinates,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  Course copyWith({
    String? id,
    Coordinates? start,
    Coordinates? end,
    Coordinates? coordinates,
  }) {
    return Course(
        id: id ?? this.id,
        start: start ?? this.start,
        end: end ?? this.end,
        coordinates: coordinates ?? this.coordinates);
  }
}
