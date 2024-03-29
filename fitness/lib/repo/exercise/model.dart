import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Exercise {
  static List<Exercise> fromJsonArray(List? list) {
    if (list == null) return [];
    return List<Map<String, dynamic>>.from(list)
        .map<Exercise>((e) => Exercise.fromJson(e))
        .toList();
  }

  final String id;
  final String name;
  final int defaultWarmups;
  final int defaultSets;
  final int defaultReps;
  final int defaultRestDuration;

  Exercise({
    required this.id,
    required this.name,
    required this.defaultWarmups,
    required this.defaultSets,
    required this.defaultReps,
    required this.defaultRestDuration,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  int get defaultRestMinutes {
    return (defaultRestDuration ~/ 60);
  }

  int get defaultRestSeconds {
    return defaultRestDuration - defaultRestMinutes * 60;
  }

  Exercise copyWith({
    String? id,
    String? name,
    String? workout,
    Exercise? next,
    int? defaultWarmups,
    int? defaultSets,
    int? defaultReps,
    int? defaultRestDuration,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultWarmups: defaultWarmups ?? this.defaultWarmups,
      defaultSets: defaultSets ?? this.defaultSets,
      defaultReps: defaultReps ?? this.defaultReps,
      defaultRestDuration: defaultRestDuration ?? this.defaultRestDuration,
    );
  }
}
