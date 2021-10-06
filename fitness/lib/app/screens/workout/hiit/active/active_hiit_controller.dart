import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/hiit/active/pose/pose_controller.dart';
import 'package:fitness/app/screens/workout/timer/timer.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:hiit_api/hiit.dart';
import 'active_hiit_state.dart';

class ActiveHIITController extends GetxController {
  final SlidingPanelController panelController;
  final FullScreenPanelController fullscreenController;
  final TimerController timerController;
  final PoseController poseController;
  final WorkoutRepo workoutRepo;

  int count = 0;

  late HIIT hiit;

  RoutineInterval? currentInterval;
  Routine? currentRoutine;

  ActiveWorkoutState state = ActiveWorkoutWorking();
  late final ResponseStream<Data> res;

  ActiveHIITController({
    SlidingPanelController? panelController,
    FullScreenPanelController? fullscreenController,
    TimerController? timerController,
  })  : this.panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.HIIT_DETAILS)
            : panelController,
        this.fullscreenController = fullscreenController == null
            ? FullScreenPanelController.get(RoutePaths.HIIT_ACTIVE)
            : fullscreenController,
        this.timerController = TimerController.get(RoutePaths.HIIT_ACTIVE),
        this.poseController = PoseController.get(),
        this.workoutRepo = WorkoutRepo.get() {
    res = workoutRepo.startHIITStream();
    res.listen(onHIITStream);
  }

  bool get poseStarted => poseController.started;

  @override
  void onInit() {
    super.onInit();
    hiit = hiit = Get.arguments;
    fullscreenController.addFullScreenListener(onFullScreenPanelChange);
  }

  @override
  void onClose() {
    super.onClose();
    res.cancel();
  }

  void onHIITStream(Data data) {
    if (data.count == count) return;
    count = data.count;
    update();
  }

  void onFullScreenPanelChange() {
    if (fullscreenController.status is FullScreenStatusOpened) return;
    poseController.stopCall();
  }

  void stopPose() async {
    if (poseController.started) await poseController.stopCall();
    update();
  }

  void startPose() async {
    if (currentRoutine == null ||
        poseController.loading ||
        poseController.started) return;
    await poseController.makeCall(
      exercise: currentRoutine!.exercise,
      user: UserController.get().user.value!,
      interval: currentInterval!,
    );
    update();
  }

  void onOpenFullPanel() {
    if (currentInterval == null) return;
    fullscreenController.open();
  }

  void onHideFullPanel() {
    fullscreenController.hide();
  }

  void onSlidingPanelClose() {
    panelController.close();
  }

  void onIntervalSelected(Routine routine, RoutineInterval interval) {
    currentInterval = interval;
    currentRoutine = routine;
    fullscreenController.open();
    update();
  }

  void onHIITEnd() {
    Get.back();
  }
}
