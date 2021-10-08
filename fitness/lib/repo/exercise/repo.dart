import 'package:fitness/repo/seed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class ExerciseRepo {
  CollectionReference collection;
  CollectionReference publicCollection;

  ExerciseRepo()
      : collection = FirebaseFirestore.instance.collection('/exercises'),
        publicCollection =
            FirebaseFirestore.instance.collection('/publicworkout');
  Future<List<Exercise>> getExercises() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Exercise>(
            (doc) => Exercise.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// Add workout to public collection
  /// With 0 users
  Future<void> addPublicWorkout(String userId, String workoutId,
      {int maxCapacity = 2}) async {
    try {
      await publicCollection.doc(workoutId).set({
        "userId": userId,
        "workoutId": workoutId,
        "participants": [],
        "maxCapacity": maxCapacity,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
