import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_interval.g.dart';

enum RoutineIntervalType {
  @JsonValue(1)
  WARMUP,
  @JsonValue(2)
  SET,
  @JsonValue(3)
  DROPSET
}

@JsonSerializable(explicitToJson: true)
class RoutineInterval {
  String id;
  final int iteration;
  final String routine;
  RoutineLog? currentLog;
  final RoutineIntervalType type;

  RoutineInterval({
    this.id = '',
    required this.iteration,
    required this.routine,
    this.currentLog,
    required this.type,
  });

  factory RoutineInterval.fromJson(Map<String, dynamic> json) =>
      _$RoutineIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineIntervalToJson(this);

  RoutineInterval copyWith({
    String? id,
    int? iteration,
    String? routine,
    RoutineLog? currentLog,
    RoutineIntervalType? type,
  }) {
    return RoutineInterval(
      id: id ?? this.id,
      iteration: iteration ?? this.iteration,
      routine: routine ?? this.routine,
      currentLog: currentLog ?? this.currentLog,
      type: type ?? this.type,
    );
  }
}
