import 'package:fitness/repo/repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

enum WorkoutType {
  @JsonValue(0)
  UNKNOWN,
  @JsonValue(1)
  CYCLING,
  @JsonValue(2)
  HIIT,
}

@JsonSerializable(explicitToJson: true)
class Workout {
  final String id;
  final String name;
  @JsonKey(defaultValue: "")
  final String host;
  final WorkoutType type;

  @JsonKey(ignore: true)
  final List<UserSnippet> participants;

  Workout({
    this.id = "",
    required this.name,
    required this.host,
    List<UserSnippet>? participants,
    this.type = WorkoutType.HIIT,
  }) : this.participants = participants == null ? [] : participants;

  Workout copyWith({
    String? id,
    String? name,
    String? host,
    WorkoutType? type,
    List<UserSnippet>? participants,
  }) {
    return Workout(
      id: id ?? this.id,
      host: host ?? this.host,
      name: name ?? this.name,
      type: type ?? this.type,
      participants: participants ?? this.participants,
    );
  }

  static String typeIntToString(int type) {
    switch (WorkoutType.values[type]) {
      case WorkoutType.CYCLING:
        return "Cycling";
      case WorkoutType.HIIT:
        return "HIIT";
      default:
        return "";
    }
  }

  static String typeToString(WorkoutType type) {
    switch (type) {
      case WorkoutType.CYCLING:
        return "Cycling";
      case WorkoutType.HIIT:
        return "HIIT";
      default:
        return "";
    }
  }

  static WorkoutType intToType(int? type) {
    return WorkoutType.values[type ?? 0];
  }

  static Map<int, String> workoutTypes() {
    final types = Map<int, String>();
    for (var v in WorkoutType.values) {
      final value = typeIntToString(v.index);
      if (value == "") continue;
      types[v.index] = typeIntToString(v.index);
    }
    return types;
  }

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
