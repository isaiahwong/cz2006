import 'package:fitness/common/common.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hiit.g.dart';

@JsonSerializable(explicitToJson: true)
class HIIT extends Workout {
  final List<Routine> routines;

  @JsonKey(ignore: true)
  final List<UserSnippet> participants;

  HIIT({
    String id = "",
    required String name,
    required String host,
    WorkoutType type = WorkoutType.HIIT, // used for json generator
    List<UserSnippet>? participants,
    this.routines = const [],
  })  : this.participants = participants == null ? [] : participants,
        super(id: id, host: host, name: name, type: WorkoutType.HIIT);

  factory HIIT.fromJson(Map<String, dynamic> json) => _$HIITFromJson(json);

  Map<String, dynamic> toJson() => _$HIITToJson(this);

  factory HIIT.fromWorkout({
    required Workout workout,
    List<Routine>? routines,
  }) {
    return HIIT(
      id: workout.id,
      host: workout.host,
      name: workout.name,
      routines: routines != null ? List<Routine>.from(routines).toList() : [],
    );
  }

  HIIT setExercises(List<Exercise> exercises) {
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

  HIIT addExercise(Exercise exercise) {
    return copyWith(
      routines: routines
        ..add(
          Routine(
            id: genRandStr(5),
            exercise: exercise.copyWith(),
            workout: this.id,
          ).generateIntervals(),
        ),
    );
  }

  HIIT updateRoutine(Routine routine) {
    return copyWith(
        routines: List<Routine>.from(routines)
            .map((r) => r.id == routine.id ? routine.copyWith() : r)
            .toList());
  }

  HIIT removeRoutineExercise(Exercise exercise) {
    return copyWith(
      routines: routines..removeWhere((r) => r.exercise.id == exercise.id),
    );
  }

  @override
  HIIT copyWith({
    String? id,
    String? name,
    String? host,
    WorkoutType? type,
    List<Routine>? routines,
    List<UserSnippet>? participants,
  }) {
    return HIIT(
      id: id ?? this.id,
      host: host ?? this.host,
      name: name ?? this.name,
      participants: participants ?? this.participants,
      routines: List<Routine>.from(routines ?? this.routines).toList(),
    );
  }

  Routine? getRoutine(String id) {
    try {
      return routines.firstWhere((e) => e.id == id);
    } catch (error) {
      return null;
    }
  }

  Routine? nextRoutine(Routine? current) {
    if (current == null) return current;
    final i = routines.indexWhere((r) => r.id == current.id);
    if (i == -1 || i == routines.length - 1) return null;
    return routines[i + 1].copyWith();
  }

  bool isLastInterval(RoutineInterval interval) {
    for (int i = 0; i < routines.length; i++)
      if (!routines[i].isLastInterval(interval)) return false;
    return true;
  }
}
