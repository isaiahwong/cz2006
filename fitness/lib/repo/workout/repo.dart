import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

import 'model/model.dart';

class WorkoutRepo {
  final FirebaseFirestore _store;
  late final CollectionReference collection;

  WorkoutRepo({required UserRepo userRepo})
      : _store = FirebaseFirestore.instance {
    collection =
        FirebaseFirestore.instance.collection('/users/${userRepo.id}/workouts');
  }

  factory WorkoutRepo.get() {
    return Get.find();
  }

  Future<Workout> createWorkout(Workout workout) async {
    final result = await collection.add(workout.toJson());
    collection.doc(result.id).update({"id": result.id});
    return workout.copyWith(id: result.id);
  }

  Future<void> updateWorkout(Workout workout) {
    return collection.doc(workout.id).set(workout.toJson());
  }

  Future<void> updateHIIT(HIIT workout) {
    return collection.doc(workout.id).set(workout.toJson());
  }

  Future<Workout> getUser(String id) {
    return collection.doc(id).get().then(
          (document) =>
              Workout.fromJson(document.data()! as Map<String, dynamic>),
        );
  }

  Stream<List<Workout>> streamWorkouts() {
    return _store
        .collection("/users/tjbV11j8nEac5DJTUKPyHqJxilE3/workouts")
        .snapshots()
        .map(
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
