import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import 'exercise.dart';

class ExerciseRepo {
  CollectionReference collection;
  FirebaseFirestore _store;
  FirebaseFunctions _functions;
  ExerciseRepo()
      : collection = FirebaseFirestore.instance.collection('/exercises'),
        _store = FirebaseFirestore.instance,
        _functions = FirebaseFunctions.instanceFor(region: "asia-east2");
  Future<List<Exercise>> getExercises() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Exercise>(
            (doc) => Exercise.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
