import 'package:fitness/repo/exercise/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum WorkoutType {
  @JsonValue("cycling")
  CYCLING,
  @JsonValue("HIIT")
  HIIT,
}

@JsonSerializable()
class Workout {
  final String id;
  final String name;
  final WorkoutType type;

  Workout({
    required this.id,
    required this.name,
    this.type = WorkoutType.HIIT,
  });

  Workout copyWith({
    String? id,
    String? name,
    WorkoutType? type,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}

@JsonSerializable()
class Routine {
  String id;
  final String workout;
  final Exercise exercise;
  final int defaultWarmups;
  final int defaultSets;
  final int defaultReps;
  final int defaultRestDuration;

  Routine({
    this.id = "",
    required this.exercise,
    required this.workout,
    required this.defaultWarmups,
    required this.defaultSets,
    required this.defaultReps,
    required this.defaultRestDuration,
  });

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineToJson(this);
}
