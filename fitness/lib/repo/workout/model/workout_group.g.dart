// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutGroup _$WorkoutGroupFromJson(Map<String, dynamic> json) {
  return WorkoutGroup(
    workoutId: json['workoutId'] as String,
    creator: json['creator'] as String,
    participants: (json['participants'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    public: json['public'] as bool,
    isActive: json['isActive'] as bool,
    maxParticipants: json['maxParticipants'] as int,
  );
}

Map<String, dynamic> _$WorkoutGroupToJson(WorkoutGroup instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'creator': instance.creator,
      'public': instance.public,
      'isActive': instance.isActive,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'maxParticipants': instance.maxParticipants,
    };

WorkoutGroupWithId _$WorkoutGroupWithIdFromJson(Map<String, dynamic> json) {
  return WorkoutGroupWithId(
    id: json['id'] as String,
    workoutId: json['workoutId'] as String,
    creator: json['creator'] as String,
    participants: (json['participants'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    public: json['public'] as bool,
    isActive: json['isActive'] as bool,
    maxParticipants: json['maxParticipants'] as int,
  );
}

Map<String, dynamic> _$WorkoutGroupWithIdToJson(WorkoutGroupWithId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'creator': instance.creator,
      'public': instance.public,
      'isActive': instance.isActive,
      'participants': instance.participants.map((e) => e.toJson()).toList(),
      'maxParticipants': instance.maxParticipants,
    };

GroupWorkout _$GroupWorkoutFromJson(Map<String, dynamic> json) {
  return GroupWorkout(
    creator: json['creator'] as String,
    workoutGroupId: json['workoutGroupId'] as String,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$GroupWorkoutToJson(GroupWorkout instance) =>
    <String, dynamic>{
      'creator': instance.creator,
      'workoutGroupId': instance.workoutGroupId,
      'isActive': instance.isActive,
    };
