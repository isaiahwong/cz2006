import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'active_hiit_state.dart';

class ActiveHIITController extends GetxController {
  final SlidingPanelController panelController;
  final FullScreenPanelController fullscreenController;

  late HIIT hiit;
  RoutineInterval? currentInterval;
  Routine? currentRoutine;

  ActiveWorkoutState state = ActiveWorkoutWorking();

  ActiveHIITController({
    SlidingPanelController? panelController,
    FullScreenPanelController? fullscreenController,
  })  : this.panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.HIIT_DETAILS)
            : panelController,
        this.fullscreenController = fullscreenController == null
            ? FullScreenPanelController.get(RoutePaths.HIIT_ACTIVE)
            : fullscreenController;

  @override
  void onInit() {
    super.onInit();
    hiit = hiit = Get.arguments;
  }

  void openPanel() {
    if (currentInterval == null) return;
    fullscreenController.open();
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
