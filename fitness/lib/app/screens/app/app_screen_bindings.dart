import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/app/app_screen_controller.dart';
import 'package:fitness/app/screens/profile/profile_controller.dart';
import 'package:get/get.dart';

class AppScreenBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(AppScreenController());
    Get.put(SlidingPanelController(tag: RoutePaths.APP), tag: RoutePaths.APP);
    Get.put(ProfileController());
  }
}
