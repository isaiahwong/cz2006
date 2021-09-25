import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_log.g.dart';

@JsonSerializable()
class RoutineLog {
  String id;
  int reps;
  RoutineInterval interval;
  bool completed;

  RoutineLog({
    required this.id,
    required this.reps,
    required this.interval,
    required this.completed,
  });

  factory RoutineLog.fromJson(Map<String, dynamic> json) =>
      _$RoutineLogFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineLogToJson(this);
}
