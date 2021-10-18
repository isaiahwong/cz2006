import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/cycling/details/cycling_details_controller.dart';
import 'package:get/instance_manager.dart';

class ActiveCyclingBindings extends Bindings {
  @override
  void dependencies() {
    final panelControllerCycling =
        SlidingPanelController(tag: RoutePaths.CYCLING_DETAILS);

    Get.lazyPut(() =>
        CyclingDetailsController(panelController: panelControllerCycling));
    Get.lazyPut(() => panelControllerCycling, tag: RoutePaths.CYCLING_ACTIVE);
  }
}
