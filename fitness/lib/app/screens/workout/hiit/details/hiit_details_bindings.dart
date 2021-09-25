import 'package:fitness/app/screens/auth/register/register_controller.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:get/get.dart';

class HIITDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HIITDetailsController());
  }
}
