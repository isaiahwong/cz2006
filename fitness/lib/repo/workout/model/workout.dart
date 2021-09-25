import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

enum WorkoutType {
  @JsonValue("cycling")
  CYCLING,
  @JsonValue("HIIT")
  HIIT,
}

@JsonSerializable(explicitToJson: true)
class Workout {
  final String id;
  final String name;
  final WorkoutType type;

  Workout({
    this.id = "",
    required this.name,
    this.type = WorkoutType.HIIT,
  });

  Workout copyWith({
    String? id,
    String? name,
    WorkoutType? type,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
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
