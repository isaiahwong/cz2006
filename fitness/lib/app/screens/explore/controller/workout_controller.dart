import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class ExploreWorkoutController extends GetxController {
  static ExploreWorkoutController to = Get.find();
  late SocialRepo _socialRepo;
  Rx<List<WorkoutGroupWithId>> _workoutGroups = Rx([]);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _socialRepo = Get.find<SocialRepo>();

    _workoutGroups.bindStream(_socialRepo.streamPublicWorkout());
    super.onReady();
  }

  // Convert to UI
  _workoutGroupHandler(WorkoutGroupWithId workout) {}

  // * Getters
  int get getPublicWorkoutLength => _workoutGroups.value.length;
}
