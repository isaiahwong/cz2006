import 'package:fitness/common/common.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hiit.g.dart';

@JsonSerializable(explicitToJson: true)
class HIIT extends Workout {
  List<Routine> routines;

  HIIT({
    String id = "",
    required String name,
    WorkoutType type = WorkoutType.HIIT, // used for json generator
    this.routines = const [],
  }) : super(id: id, name: name, type: WorkoutType.HIIT);

  factory HIIT.fromJson(Map<String, dynamic> json) => _$HIITFromJson(json);

  Map<String, dynamic> toJson() => _$HIITToJson(this);

  factory HIIT.fromWorkout({
    required Workout workout,
    List<Routine>? routines,
  }) {
    return HIIT(
      id: workout.id,
      name: workout.name,
      routines: routines != null ? List<Routine>.from(routines).toList() : [],
    );
  }

  HIIT addExercises(List<Exercise> exercises) {
    return copyWith(
      routines: exercises
          .map(
            (ex) => Routine(
              id: genRandStr(5),
              workout: this.id,
              exercise: ex.copyWith(),
            ).generateIntervals(),
          )
          .toList(),
    );
  }

  @override
  HIIT copyWith({
    String? id,
    String? name,
    WorkoutType? type,
    List<Routine>? routines,
  }) {
    return HIIT(
      id: id ?? this.id,
      name: name ?? this.name,
      routines: List<Routine>.from(routines ?? this.routines).toList(),
    );
  }
}
