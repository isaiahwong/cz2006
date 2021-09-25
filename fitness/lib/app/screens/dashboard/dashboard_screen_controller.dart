import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class DashboardScreenController extends GetxController {
  WorkoutRepo repo = WorkoutRepo.get();

  RxList<Workout> workouts = RxList<Workout>([]);

  @override
  void onReady() async {
    workouts.bindStream(repo.streamWorkouts());
    ever(workouts, (items) => update());

    super.onReady();
  }

  void onCreate() {
    final slide = SlidingPanelController.to;
    slide.open(panel: CreateWorkoutScreen.get());
  }

  @override
  void onClose() {
    super.onClose();
    workouts.close();
  }
}
