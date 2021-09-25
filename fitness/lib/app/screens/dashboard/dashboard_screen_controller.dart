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

  @override
  void onClose() {
    super.onClose();
    workouts.close();
  }
}
