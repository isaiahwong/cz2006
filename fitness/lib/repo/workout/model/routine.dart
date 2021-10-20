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

  bool get completed {
    for (int i = 0; i < intervals.length; i++)
      if (!intervals[i].currentLog.completed) return false;
    return true;
  }

  int get sets => intervals.fold(
      0, (p, element) => element.type == RoutineIntervalType.SET ? p + 1 : 0);

  Routine({
    this.id = '',
    required this.exercise,
    required this.workout,
    this.intervals = const [],
    this.score = 0,
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
          defaultReps: exercise.defaultReps,
          defaultSets: exercise.defaultSets,
          defaultWarmups: exercise.defaultWarmups,
          defaultRestDuration: exercise.defaultRestDuration,
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
          defaultReps: exercise.defaultReps,
          defaultSets: exercise.defaultSets,
          defaultWarmups: exercise.defaultWarmups,
          defaultRestDuration: exercise.defaultRestDuration,
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
    );
  }

  Routine updateInterval(RoutineInterval interval) {
    return copyWith(
      intervals: List<RoutineInterval>.from(intervals)
          .map((i) => i.id == interval.id ? interval.copyWith() : i)
          .toList(),
    );
  }

  RoutineInterval? nextInterval({RoutineInterval? current}) {
    if (current == null) return intervals.first;
    final i = intervals.indexWhere((r) => r.id == current.id);
    if (i == -1 || i == intervals.length - 1) return null;
    return intervals[i + 1].copyWith();
  }

  bool isLastInterval(RoutineInterval interval) {
    for (int i = 0; i < intervals.length; i++)
      if (!intervals[i].currentLog.completed && intervals[i].id != interval.id)
        return false;
    return true;
  }

  RoutineInterval? getCurrentInterval() {
    try {
      return intervals.firstWhere((r) => !(r.currentLog.completed));
    } catch (error) {
      return null;
    }
  }

  RoutineInterval? getInterval(String id) {
    try {
      return intervals.firstWhere((r) => r.id == id);
    } catch (error) {
      return null;
    }
  }
}
