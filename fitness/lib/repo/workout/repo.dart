import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

import 'model/model.dart';

class WorkoutRepo {
  final FirebaseFirestore _store;
  late final CollectionReference collection;
  late final StreamSubscription<User> userStream;

  WorkoutRepo({required UserRepo userRepo})
      : _store = FirebaseFirestore.instance {
    userRepo.streamUser().listen((user) {
      collection =
          FirebaseFirestore.instance.collection('/users/${user.id}/workouts');
    });
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
