import 'package:fitness/common/common.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_interval.g.dart';

enum RoutineIntervalType {
  @JsonValue(0)
  UNKNOWN,
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
  final RoutineLog currentLog;
  final List<RoutineLog> logs;
  final RoutineIntervalType type;
  final int defaultWarmups;
  final int defaultSets;
  final int defaultReps;
  final int defaultRestDuration;

  RoutineInterval({
    this.id = '',
    required this.iteration,
    required this.routine,
    RoutineLog? currentLog,
    required this.type,
    required this.defaultWarmups,
    required this.defaultSets,
    required this.defaultReps,
    required this.defaultRestDuration,
    List<RoutineLog> logs = const [],
  })  : this.logs = List.from(logs),
        this.currentLog = currentLog != null
            ? currentLog
            : RoutineLog(
                id: genRandStr(6),
                reps: defaultReps,
                interval: id,
                completed: false,
              );

  factory RoutineInterval.fromJson(Map<String, dynamic> json) =>
      _$RoutineIntervalFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineIntervalToJson(this);

  RoutineInterval copyWith({
    String? id,
    int? iteration,
    String? routine,
    RoutineLog? currentLog,
    RoutineIntervalType? type,
    int? defaultWarmups,
    int? defaultSets,
    int? defaultReps,
    int? defaultRestDuration,
  }) {
    return RoutineInterval(
      id: id ?? this.id,
      iteration: iteration ?? this.iteration,
      routine: routine ?? this.routine,
      currentLog: currentLog ?? this.currentLog,
      type: type ?? this.type,
      defaultWarmups: defaultWarmups ?? this.defaultWarmups,
      defaultSets: defaultSets ?? this.defaultSets,
      defaultReps: defaultReps ?? this.defaultReps,
      defaultRestDuration: defaultRestDuration ?? this.defaultRestDuration,
    );
  }

  static String typeToString(RoutineIntervalType type) {
    switch (type) {
      case RoutineIntervalType.WARMUP:
        return "Warmup";
      case RoutineIntervalType.SET:
        return "Set";
      default:
        return "";
    }
  }
}
