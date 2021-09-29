import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class ActiveHIITController extends GetxController {
  late HIIT hiit;
  late RoutineInterval currentInterval;

  @override
  void onInit() {
    super.onInit();
    hiit = hiit = Get.arguments;
  }
}
