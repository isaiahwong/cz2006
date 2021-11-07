import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/cycling/course/course.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fitness/common/common.dart';

part 'cycling.g.dart';

@JsonSerializable(explicitToJson: true)
class Cycling extends Workout {
  List<Course> course;

  Cycling({
    String id = "",
    required String name,
    required String host,
    this.course = const [],
    List<UserSnippet>? participants,
    WorkoutType type = WorkoutType.CYCLING, // used for json generator
  }) : super(
          id: id,
          host: host,
          name: name,
          type: WorkoutType.CYCLING,
          participants: participants,
        );

  factory Cycling.fromJson(Map<String, dynamic> json) =>
      _$CyclingFromJson(json);

  Map<String, dynamic> toJson() => _$CyclingToJson(this);

  factory Cycling.fromWorkout({
    required Workout workout,
    List<Course>? course,
  }) {
    return Cycling(
      id: workout.id,
      host: workout.host,
      name: workout.name,
      course: course != null ? List<Course>.from(course).toList() : [],
      participants: workout.participants,
    );
  }

  Cycling setCoordinates(List<Coordinates> coordinates) {
    return copyWith(
      course: coordinates
          .map(
            (coords) => Course(
              id: genRandStr(5),
              start: coordinates[0],
              end: coordinates[1],
              coordinates: coords.copyWith(),
            ),
          )
          .toList(),
    );
  }

  @override
  Cycling copyWith({
    String? id,
    String? name,
    String? host,
    WorkoutType? type,
    List<UserSnippet>? participants,
    List<Course>? course,
  }) {
    return Cycling(
      id: id ?? this.id,
      host: host ?? this.host,
      name: name ?? this.name,
      participants: participants ?? this.participants,
      course: List<Course>.from(course ?? this.course).toList(),
    );
  }
}
