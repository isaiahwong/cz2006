import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/hiit/active/components/components.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:get/get.dart';

class ActiveHIITBindings extends Bindings {
  @override
  void dependencies() {
    // Delete any existing controller states
    Get.delete<FullScreenPanelController>(force: true);
    final panelController = SlidingPanelController(tag: RoutePaths.HIIT_ACTIVE);
    Get.lazyPut(
        () => FullScreenPanelController(
              panelHeader: CurrentRoutinePanelHeader(),
            ),
        tag: RoutePaths.HIIT_ACTIVE);
    Get.lazyPut(() => ActiveHIITController());
    Get.lazyPut(() => panelController, tag: RoutePaths.HIIT_ACTIVE);
  }
}
