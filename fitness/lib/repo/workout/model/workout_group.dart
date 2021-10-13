import 'package:fitness/repo/user/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_group.g.dart';

/// Model for Workout group collection
/// * For adding into collection
@JsonSerializable(explicitToJson: true)
class WorkoutGroup {
  String workoutId;
  String creator;
  bool public;
  bool isActive;
  List<User> participants;
  int maxParticipants;

  WorkoutGroup({
    required this.workoutId,
    required this.creator,
    required this.participants,
    this.public = false,
    this.isActive = true,
    this.maxParticipants = 2,
  });

  WorkoutGroup copyWith({
    String? workoutId,
    String? creator,
    bool? public,
    bool? isActive,
    List<User>? participants,
    int? maxParticipants,
  }) {
    return WorkoutGroup(
      workoutId: workoutId ?? this.workoutId,
      creator: creator ?? this.creator,
      public: public ?? this.public,
      isActive: isActive ?? this.isActive,
      participants: participants ?? this.participants,
      maxParticipants: maxParticipants ?? this.maxParticipants,
    );
  }

  factory WorkoutGroup.fromJson(Map<String, dynamic> json) =>
      _$WorkoutGroupFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutGroupToJson(this);
}

/// Used for returning widg
@JsonSerializable(explicitToJson: true)
class WorkoutGroupWithId extends WorkoutGroup {
  String id;
  String workoutId;
  String creator;
  bool public;
  bool isActive;
  List<User> participants;
  int maxParticipants;

  WorkoutGroupWithId({
    required this.id,
    required this.workoutId,
    required this.creator,
    required this.participants,
    this.public = false,
    this.isActive = true,
    this.maxParticipants = 2,
  }) : super(
          workoutId: workoutId,
          creator: creator,
          participants: participants,
          isActive: isActive,
          maxParticipants: maxParticipants,
          public: public,
        );

  @override
  WorkoutGroupWithId copyWith(
      {String? id,
      String? workoutId,
      String? creator,
      List<User>? participants,
      bool? public,
      bool? isActive,
      int? maxParticipants}) {
    return WorkoutGroupWithId(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      creator: creator ?? this.creator,
      participants: participants ?? this.participants,
      isActive: isActive ?? this.isActive,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      public: public ?? this.public,
    );
  }

  factory WorkoutGroupWithId.fromJson(Map<String, dynamic> json) =>
      _$WorkoutGroupWithIdFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutGroupWithIdToJson(this);
}

/// GroupWorkout
/// - Sub collection under user added as invitation
@JsonSerializable(explicitToJson: true)
class GroupWorkout {
  /// Creator user id
  String creator;
  String workoutGroupId;
  bool isActive;

  GroupWorkout({
    required this.creator,
    required this.workoutGroupId,
    required this.isActive,
  });

  GroupWorkout copyWith(
      {String? creator, String? workoutGroupId, bool? isActive}) {
    return GroupWorkout(
      creator: creator ?? this.creator,
      workoutGroupId: workoutGroupId ?? this.workoutGroupId,
      isActive: isActive ?? this.isActive,
    );
  }

  factory GroupWorkout.fromJson(Map<String, dynamic> json) =>
      _$GroupWorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$GroupWorkoutToJson(this);
}
