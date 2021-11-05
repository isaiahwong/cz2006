import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

import 'model/model.dart';

abstract class WorkoutRepo {
  late final UserRepo _userRepo;
  late final HIITServiceClient hiitClient;

  factory WorkoutRepo.get() {
    return Get.find();
  }

  ResponseStream<Data> startHIITStream();

  ResponseStream<WaitingRoomResponse> createWaitingRoom(Workout workout);

  ResponseStream<WaitingRoomResponse> joinWaitingRoom(Workout workout);

  Future<void> startWaitingRoom(HIIT hiit);

  ResponseStream<HIITActivity> createDuoHIIT(HIIT hiit);

  ResponseStream<HIITActivity> joinDuoHIIT(HIIT hiit);

  Future<void> duoHIITRoutineComplete(Routine routine);

  Future<void> duoHIITIntervalComplete(
      Routine routine, RoutineInterval interval);

  ResponseStream<InviteWaitingRoomRequest> subscribeInvites(User user);

  Future<void> duoHIITSelectRoutine(Routine routine, RoutineInterval interval);

  Future<Workout> createWorkout(Workout workout);

  Future<void> notifyInvite(UserSnippet friend, Workout workout);

  Future<Workout> findWorkoutByUser(String user, String id);

  Future<void> updateWorkout(Workout workout);

  Future<void> updateHIIT(HIIT workout);

  Future<void> updateCycling(Cycling workout);

  Future<Workout> getUser(String id);

  Future<List<Workout>> getWorkouts();

  Stream<List<Workout>> streamWorkouts();
}
