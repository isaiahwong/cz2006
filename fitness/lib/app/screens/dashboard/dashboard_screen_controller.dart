import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class DashboardScreenController extends GetxController {
  final SlidingPanelController panelController = Get.find(tag: RoutePaths.APP);
  final WorkoutRepo repo = WorkoutRepo.get();

  RxList<Workout> workouts = RxList<Workout>([]);

  @override
  void onReady() async {
    workouts.bindStream(repo.streamWorkouts());
    ever(workouts, (items) => update());

    super.onReady();
  }

  void onHIITSelected(HIIT hiit) {
    Get.toNamed(RoutePaths.HIIT_DETAILS, arguments: hiit.copyWith());
  }

  void onCyclingSelected(Cycling cycling) {
    Get.toNamed(RoutePaths.CYCLING_DETAILS, arguments: cycling.copyWith());
  }

  void onCreate() {
    panelController.open(panel: CreateWorkoutScreen.get());
  }

  @override
  void onClose() {
    super.onClose();
    workouts.close();

    Get.find<ExploreController>().onClose();
  }
}
