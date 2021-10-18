import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/repo/user/user.dart';
import 'package:get/get.dart';

class CyclingRepo {
  late final UserRepo _userRepo;
  CollectionReference collection;

  CyclingRepo({
    required UserRepo userRepo,
  })  : collection = FirebaseFirestore.instance
            .collection('/users/${userRepo.id}/workouts'),
        _userRepo = userRepo;

  factory CyclingRepo.get() {
    return Get.find();
  }
}
