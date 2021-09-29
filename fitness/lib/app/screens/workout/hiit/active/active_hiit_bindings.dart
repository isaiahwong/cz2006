import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/screens/workout/hiit/active/components/components.dart';
import 'package:get/get.dart';

class ActiveHIITBindings extends Bindings {
  @override
  void dependencies() {
    // Delete any existing controller states
    Get.delete<FullScreenPanelController>(force: true);
    Get.lazyPut(
        () => FullScreenPanelController(panel: CurrentRoutinePanelHeader()));
  }
}
