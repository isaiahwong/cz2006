import 'package:fitness/app/controllers/auth/auth_controller.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/hiit/room/waiting_room_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:hiit_api/hiit.dart';

class WorkoutController extends GetxController {
  final WorkoutRepo _workoutRepo;

  ResponseStream<InviteWaitingRoomRequest>? invitationRequest;
  List<Workout> publicWorkouts = [];

  WorkoutController({required WorkoutRepo workoutRepo})
      : _workoutRepo = workoutRepo {
    connect();
  }

  factory WorkoutController.get() {
    return Get.find();
  }

  void connect() {
    final user = UserController.get().user.value!;
    invitationRequest = _workoutRepo.subscribeInvites(user);
    invitationRequest!.listen(onInvitationRequest);
  }

  @override
  void onInit() async {
    publicWorkouts = await getWorkouts();
    super.onInit();
  }

  void onInvitationRequest(InviteWaitingRoomRequest request) async {
    final workout =
        await _workoutRepo.findWorkoutByUser(request.from.id, request.workout);

    // TODO open dialog

    if (workout is HIIT) {
      final hiit = workout;
      Get.toNamed(RoutePaths.HIIT_WAITING_ROOM, arguments: [
        WaitingRoomType.INVITEE,
        hiit.copyWith(),
      ]);
    }
  }

  Future<List<Workout>> getWorkouts() {
    return _workoutRepo.getWorkouts();
  }

  @override
  void onClose() {
    invitationRequest?.cancel();
  }
}
