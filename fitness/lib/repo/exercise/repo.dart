import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

import 'exercise.dart';

class ExerciseRepo {
  CollectionReference collection;
  CollectionReference workoutGroupsCollection;
  FirebaseFunctions _functions;
  FirebaseFirestore _store;

  ExerciseRepo()
      : collection = FirebaseFirestore.instance.collection('/exercises'),
        workoutGroupsCollection =
            FirebaseFirestore.instance.collection('/workoutgroups'),
        _store = FirebaseFirestore.instance,
        _functions = FirebaseFunctions.instanceFor(region: "asia-east2");
  Future<List<Exercise>> getExercises() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Exercise>(
            (doc) => Exercise.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  factory ExerciseRepo.get() {
    return Get.find<ExerciseRepo>();
  }

  /// Add a workout to group (allowing > 1 users)
  Future<ResponseMessage> createGroupWorkout(WorkoutGroup group) async {
    var result;
    try {
      result = await _functions
          .httpsCallable("workout-createGroupWorkout")
          .call(group.toJson());
    } catch (e) {
      print(e.toString());
    }
    return ResponseMessage.fromJson(result.data);
  }

  /// Takes in id for workoutGroup document
  Future<ResponseMessage> joinWorkout(String workoutGroupId) async {
    var result;
    try {
      result = await _functions.httpsCallable("workout-joinWorkoutGroup").call({
        "workoutGroupId": workoutGroupId,
      });
    } catch (e) {
      print(e.toString());
    }
    return ResponseMessage.fromJson(result.data);
  }

  /// Invite user to workout session
  Future<ResponseMessage> inviteWorkout({
    required String workoutGroupId,
    required String userId,
  }) async {
    var result;
    try {
      result = await _functions.httpsCallable("workout-inviteWorkout").call({
        "workoutGroupId": workoutGroupId,
        "userId": userId,
      });
    } catch (e) {
      print(e.toString());
    }
    return ResponseMessage.fromJson(result.data);
  }

  /// Toggle workout (isActive) status
  /// e.g. When workout has ended
  Future<void> setWorkoutStatus({
    required String workoutGroupId,
    bool isActive = false,
  }) async {
    try {
      _functions.httpsCallable("workout-setWorkoutStatus").call({
        "workoutGroupId": workoutGroupId,
        "isActive": isActive,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// Fetch workout from user sub collection
  /// TODO: Decide on how to return different type workout
  Future<dynamic> getWorkout({
    required String workoutId,
    required userId,
  }) async {
    var result = await _store
        .collection("users")
        .doc(userId)
        .collection("workouts")
        .doc(workoutId)
        .get();
    // Determine if exercise is cycling / HIIT
    if (!result.exists) {
      return null;
    }
    var exercsie = Workout.fromJson(result.data()!);
    if (exercsie.type == WorkoutType.CYCLING) {
      return Cycling.fromJson(result.data()!);
    }
    if (exercsie.type == WorkoutType.HIIT) {
      return HIIT.fromJson(result.data()!);
    }
    return null;
  }
}
