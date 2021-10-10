import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/timer/timer.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:get/get.dart';

import 'pose/pose_controller.dart';

class ActiveHIITBindings extends Bindings {
  @override
  void dependencies() {
    // Delete any existing controller states
    Get.delete<FullScreenPanelController>(force: true);
    final panelController = SlidingPanelController(tag: RoutePaths.HIIT_ACTIVE);
    final timerController = TimerController();
    final fullscreenController = FullScreenPanelController(
      panelHeader: CurrentRoutinePanelHeader(),
      panel: CurrentRoutinePanel(),
    );

    Get.lazyPut(() => ActiveHIITController(
          timerController: timerController,
          panelController: panelController,
          fullscreenController: fullscreenController,
        ));
    Get.lazyPut(() => PoseController());
    Get.lazyPut(() => fullscreenController, tag: RoutePaths.HIIT_ACTIVE);
    Get.lazyPut(() => timerController, tag: RoutePaths.HIIT_ACTIVE);
    Get.lazyPut(() => panelController, tag: RoutePaths.HIIT_ACTIVE);
  }
}
