import 'package:fitness/repo/seed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'coordinates.dart';

class ExerciseRepo {
  CollectionReference collection;

  ExerciseRepo()
      : collection = FirebaseFirestore.instance.collection('/coordinates');
  Future<List<Coordinates>> getExercises() async {
    final snapshot = await collection.get();
    return snapshot.docs
        .map<Coordinates>(
            (doc) => Coordinates.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
