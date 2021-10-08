import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/cycling/coordinates_controller.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:fitness/repo/cycling/coordinates.dart';
import 'package:get/get.dart';

class HIITDetailsBindings extends Bindings {
  @override
  void dependencies() async {
    final panelController =
        SlidingPanelController(tag: RoutePaths.HIIT_DETAILS);
    Get.lazyPut(() => CoordinatesRepo());
    Get.lazyPut(() => HIITDetailsController(panelController: panelController));
    Get.lazyPut(() => panelController, tag: RoutePaths.HIIT_DETAILS);
  }
}
