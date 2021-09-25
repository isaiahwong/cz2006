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
