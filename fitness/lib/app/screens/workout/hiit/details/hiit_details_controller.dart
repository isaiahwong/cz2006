import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/exercise/exercise.dart';
import 'package:fitness/app/screens/exercise/exercise_controller.dart';
import 'package:fitness/app/screens/exercise/exercise_delegate.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class HIITDetailsController extends GetxController with ExerciseDelegate {
  late HIIT hiit;
  final WorkoutRepo workoutRepo = WorkoutRepo.get();

  @override
  void onInit() {
    super.onInit();
    hiit = Get.arguments;
  }

  void updateName(String name) async {
    hiit = hiit.copyWith(name: name.trimRight());
    await workoutRepo.updateHIIT(hiit);
    update();
  }

  void onNewRoutine() {
    final slide = SlidingPanelController.to;
    slide.open(
      panel: ExerciseListScreen.component(
          exerciseController: ExerciseController(
        delegateController: this,
      )),
    );
  }

  @override
  bool exists(Exercise ex) {
    return false;
  }

  @override
  bool notExists(Exercise ex) {
    return false;
  }

  @override
  void onExerciseChanged(Exercise ex) {
    // TODO: implement onExerciseChanged
  }

  @override
  void onExerciseRemoved(Exercise ex) {
    // TODO: implement onExerciseRemoved
  }

  @override
  void onExerciseSelected(Exercise ex) {}

  @override
  void onExercisesChanged(List<Exercise> exercises) {}
}
