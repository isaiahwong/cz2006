import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

import 'model/model.dart';

class WorkoutRepo {
  late final UserRepo _userRepo;
  CollectionReference collection;

  WorkoutRepo({required UserRepo userRepo})
      : collection = FirebaseFirestore.instance
            .collection('/users/${userRepo.id}/workouts'),
        _userRepo = userRepo;

  factory WorkoutRepo.get() {
    return Get.find();
  }

  Future<Workout> createWorkout(Workout workout) async {
    FirebaseFirestore.instance.collection('/users/${_userRepo.id}/workouts');
    final result = await collection.add(workout.toJson());
    // updates async
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
          (snapshot) => snapshot.docs.map((document) {
            final data = document.data() as Map<String, dynamic>;
            switch (Workout.intToType(data["type"])) {
              case WorkoutType.UNKNOWN:
                break;
              case WorkoutType.CYCLING:
                break;
              case WorkoutType.HIIT:
                return HIIT.fromJson(
                  data,
                );
            }
            return Workout.fromJson(
              data,
            );
          }).toList(),
        );
  }
}
