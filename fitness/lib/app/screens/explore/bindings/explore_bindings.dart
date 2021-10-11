import 'package:fitness/app/screens/screens.dart';
import 'package:get/get.dart';

class ExploreBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SocialController(), permanent: true);
    Get.put(ExploreWorkoutController(), permanent: true);
  }
}
