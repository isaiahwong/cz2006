import 'package:json_annotation/json_annotation.dart';

part 'routine_log.g.dart';

@JsonSerializable(explicitToJson: true)
class RoutineLog {
  String id;
  int reps;
  String interval;
  bool completed;

  RoutineLog({
    this.id = "",
    required this.reps,
    this.interval = "",
    this.completed = false,
  });

  factory RoutineLog.fromJson(Map<String, dynamic> json) =>
      _$RoutineLogFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineLogToJson(this);

  RoutineLog copyWith({
    String? id,
    int? reps,
    String? interval,
    bool? completed,
  }) {
    return RoutineLog(
      id: id ?? this.id,
      reps: reps ?? this.reps,
      interval: interval ?? this.interval,
      completed: completed ?? this.completed,
    );
  }
}
