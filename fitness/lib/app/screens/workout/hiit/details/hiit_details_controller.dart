import 'package:fitness/app/screens/workout/workout_controller.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:fitness/repo/workout/model/workout.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:get/get.dart';

class HIITDetailsController extends GetxController {
  late HIIT hiit;

  @override
  void onInit() {
    super.onInit();
    hiit = Get.arguments;
  }
}
