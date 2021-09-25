import 'package:fitness/repo/workout/model/model.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_interval.g.dart';

enum RoutineIntervalType {
  @JsonValue("Warmup")
  WARMUP,
  @JsonValue("Set")
  SET,
  @JsonValue("Dropset")
  DROPSET
}

@JsonSerializable()
class RoutineInterval {
  String id;
  final int iteration;
  final Routine routine;
  final RoutineLog currentLog;
  final RoutineIntervalType type;

  RoutineInterval({
    this.id = '',
    required this.iteration,
    required this.routine,
    required this.currentLog,
    required this.type,
  });

  factory RoutineInterval.fromJson(Map<String, dynamic> json) =>
      _$RoutineIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineIntervalToJson(this);

  RoutineInterval copyWith({
    String? id,
    int? iteration,
    Routine? routine,
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
