import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:get/get.dart';

import 'room.dart';

class WaitingRoomBindings extends Bindings {
  @override
  void dependencies() async {
    final panelController =
        SlidingPanelController(tag: RoutePaths.HIIT_DETAILS);
    Get.lazyPut(() => WaitingRoomController(panelController: panelController));
    Get.lazyPut(() => panelController, tag: RoutePaths.HIIT_WAITING_ROOM);
  }
}
