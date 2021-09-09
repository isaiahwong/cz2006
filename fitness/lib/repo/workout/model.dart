import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

enum WorkoutType {
  @JsonValue("cycling")
  CYCLING,
  @JsonValue("HIIT")
  HIIT,
}

@JsonSerializable()
class Workout {
  final String id;
  final String name;
  final WorkoutType type;

  Workout({
    required this.id,
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

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
