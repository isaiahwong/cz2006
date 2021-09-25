import 'package:fitness/common/common.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine.g.dart';

@JsonSerializable(explicitToJson: true)
class Routine {
  String id;
  final String workout;
  final Exercise exercise;
  final int score;

  final List<RoutineInterval> intervals;
  final bool completed;

  Routine({
    this.id = '',
    required this.exercise,
    required this.workout,
    this.intervals = const [],
    this.score = 0,
    this.completed = false,
  });

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineToJson(this);

  Routine generateIntervals() {
    return copyWith(intervals: [
      // generate warmup items
      ...List<RoutineInterval>.generate(
        exercise.defaultWarmups,
        (i) => RoutineInterval(
          id: genRandStr(6),
          iteration: i + 1,
          routine: this.id,
          type: RoutineIntervalType.WARMUP,
        ),
      ),
      // generate sets
      ...List<RoutineInterval>.generate(
        exercise.defaultSets,
        (i) => RoutineInterval(
          id: genRandStr(6),
          iteration: i + 1,
          routine: this.id,
          type: RoutineIntervalType.SET,
        ),
      ),
    ]);
  }

  Routine copyWith({
    String? id,
    String? workout,
    Exercise? exercise,
    List<RoutineInterval>? intervals,
    int? defaultWarmups,
    int? defaultSets,
    int? score,
    int? defaultReps,
    int? defaultRestDuration,
    bool? completed,
  }) {
    return Routine(
      id: id ?? this.id,
      workout: workout ?? this.workout,
      intervals: intervals ?? this.intervals,
      exercise: exercise ?? this.exercise,
      score: score ?? this.score,
      completed: completed ?? this.completed,
    );
  }
}
