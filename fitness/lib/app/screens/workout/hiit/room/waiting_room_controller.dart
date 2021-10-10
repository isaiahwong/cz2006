import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

class WaitingRoomController extends GetxController {
  late HIIT hiit;
  final WorkoutRepo workoutRepo;
  List<User> users = [];
  late final ResponseStream<WaitingRoomResponse> res;

  WaitingRoomController() : this.workoutRepo = WorkoutRepo.get();

  @override
  void onInit() {
    super.onInit();
    hiit = Get.arguments;

    res = workoutRepo.createWaitingRoom(hiit);
    res.listen(onWaitingRoomStream);
  }

  @override
  void onClose() {
    res.cancel();
    super.onClose();
  }

  void onWaitingRoomStream(WaitingRoomResponse response) {
    List<User> users = [];
    for (HIITUser user in response.users)
      users.add(User(id: user.id, email: user.email, name: user.name));
    this.users = users;
    update();
  }
}
