import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class WorkoutRepo {
  final FirebaseFirestore _store;
  late final CollectionReference collection;

  WorkoutRepo() : _store = FirebaseFirestore.instance {
    collection = FirebaseFirestore.instance.collection('workouts');
  }

  Future<void> createWorkout(Workout workout) async {
    await collection.add(workout.toJson());
  }

  Future<Workout> getUser(String id) {
    return collection.doc(id).get().then(
          (document) =>
              Workout.fromJson(document.data()! as Map<String, dynamic>),
        );
  }

  Stream<List<Workout>> streamWorkouts() {
    return collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Workout.fromJson(
                  document.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
