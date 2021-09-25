import 'package:fitness/repo/workout/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hiit.g.dart';

@JsonSerializable()
class HIIT extends Workout {
  List<Routine> routines;

  HIIT({
    required String id,
    required String name,
    this.routines = const [],
  }) : super(id: id, name: name, type: WorkoutType.HIIT);

  factory HIIT.fromJson(Map<String, dynamic> json) => _$HIITFromJson(json);

  Map<String, dynamic> toJson() => _$HIITToJson(this);
}
