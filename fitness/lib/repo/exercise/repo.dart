import 'package:fitness/repo/seed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'exercise.dart';

class ExerciseRepo {
  CollectionReference collection;

  ExerciseRepo()
      : collection = FirebaseFirestore.instance.collection('/exercises');
  Future<List<Exercise>> getExercises() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Exercise>(
            (doc) => Exercise.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
