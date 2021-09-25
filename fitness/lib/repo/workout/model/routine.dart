import 'package:fitness/repo/exercise/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine.g.dart';

@JsonSerializable()
class Routine {
  String id;
  final String workout;
  final Exercise exercise;
  final int defaultWarmups;
  final int defaultSets;
  final int score;
  final int defaultReps;
  final int defaultRestDuration;
  final bool completed;

  Routine({
    this.id = "",
    required this.exercise,
    required this.workout,
    required this.defaultWarmups,
    required this.defaultSets,
    required this.defaultReps,
    required this.score,
    required this.completed,
    required this.defaultRestDuration,
  });

  factory Routine.fromJson(Map<String, dynamic> json) =>
      _$RoutineFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineToJson(this);

  Routine copyWith({
    String? id,
    String? workout,
    Exercise? exercise,
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
      exercise: exercise ?? this.exercise,
      defaultWarmups: defaultWarmups ?? this.defaultWarmups,
      defaultSets: defaultSets ?? this.defaultSets,
      score: score ?? this.score,
      defaultReps: defaultReps ?? this.defaultReps,
      defaultRestDuration: defaultRestDuration ?? this.defaultRestDuration,
      completed: completed ?? this.completed,
    );
  }
}
