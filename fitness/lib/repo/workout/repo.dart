import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

import 'model/model.dart';

class WorkoutRepo {
  late final UserRepo _userRepo;
  CollectionReference collection;
  late final HIITServiceClient hiitClient;

  WorkoutRepo({
    required UserRepo userRepo,
    required this.hiitClient,
  })  : collection = FirebaseFirestore.instance
            .collection('/users/${userRepo.id}/workouts'),
        _userRepo = userRepo;

  factory WorkoutRepo.get() {
    return Get.find();
  }

  ResponseStream<Data> startHIITStream() {
    return hiitClient.sub(RoutineChange(),
        options: CallOptions(metadata: {
          "id": UserController.get().user.value!.id,
        }));
  }

  ResponseStream<WaitingRoomResponse> createWaitingRoom(HIIT hiit) {
    final user = UserController.get().user.value!;
    return hiitClient.createWaitingRoom(
      CreateWaitingRoomRequest(
        workout: hiit.id,
        host: WorkoutUser(
          id: user.id,
          name: user.name,
        ),
      ),
      options: CallOptions(
        metadata: {
          "id": user.id,
        },
      ),
    );
  }

  ResponseStream<WaitingRoomResponse> joinWaitingRoom(HIIT hiit) {
    final user = UserController.get().user.value!;
    return hiitClient.joinWaitingRoom(
      WaitingRoomRequest(
          workout: hiit.id,
          user: WorkoutUser(
            email: user.email,
            id: user.id,
            name: user.name,
          )),
      options: CallOptions(
        metadata: {
          "id": user.id,
        },
      ),
    );
  }

  Future<void> startWaitingRoom(HIIT hiit) {
    final user = UserController.get().user.value!;
    return hiitClient.startWaitingRoom(
      StartWaitingRoomRequest(
        workout: hiit.id,
        host: WorkoutUser(
          email: user.email,
          id: user.id,
          name: user.name,
        ),
      ),
      options: CallOptions(
        metadata: {
          "id": user.id,
        },
      ),
    );
  }

  ResponseStream<DuoHIITResult> createDuoHIIT(HIIT hiit) {
    final user = UserController.get().user.value!;
    return hiitClient.createDuoHIIT(
      CreateDuoHIITRequest(
        hiit: hiit.id,
        host: WorkoutUser(
          email: user.email,
          id: user.id,
          name: user.name,
        ),
      ),
      options: CallOptions(
        metadata: {
          "id": user.id,
        },
      ),
    );
  }

  Future<Workout> createWorkout(Workout workout) async {
    // FirebaseFirestore.instance.collection('/users/${_userRepo.id}/workouts');
    final result = await collection.add(workout.toJson());
    // updates async
    collection.doc(result.id).update({"id": result.id});
    return workout.copyWith(id: result.id);
  }

  Future<void> notifyInvite(UserSnippet friend, HIIT hiit) async {
    final user = UserController.get().user.value!;
    await hiitClient.notifyInvites(
      InviteWaitingRoomRequest(
        from: WorkoutUser(id: user.id, name: user.name),
        to: WorkoutUser(id: friend.id, name: friend.name),
        workout: hiit.id,
      ),
    );
  }

  Future<Workout> findWorkoutByUser(String user, String id) async {
    final result = await FirebaseFirestore.instance
        .collection('/users/$user/workouts')
        .doc(id)
        .get();
    final data = result.data() as Map<String, dynamic>;

    switch (Workout.intToType(data["type"])) {
      case WorkoutType.UNKNOWN:
        break;
      case WorkoutType.CYCLING:
        return Cycling.fromJson(data);
      case WorkoutType.HIIT:
        return HIIT.fromJson(data);
    }
    return Workout.fromJson(
      data,
    );
  }

  Future<void> updateWorkout(Workout workout) {
    return collection.doc(workout.id).set(workout.toJson());
  }

  Future<void> updateHIIT(HIIT workout) {
    return collection.doc(workout.id).set(workout.toJson());
  }

  Future<void> updateCycling(Cycling workout) {
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
                return Cycling.fromJson(data);
              case WorkoutType.HIIT:
                return HIIT.fromJson(data);
            }
            return Workout.fromJson(
              data,
            );
          }).toList(),
        );
  }
}
