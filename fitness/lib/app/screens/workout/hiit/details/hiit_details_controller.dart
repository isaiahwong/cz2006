import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
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
  final SlidingPanelController panelController;

  @override
  Map<String, Exercise> exercises = {};

  HIITDetailsController({SlidingPanelController? panelController})
      : panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.WORKOUT_DETAILS)
            : panelController;

  @override
  void onInit() {
    super.onInit();
    // Get HIIT passed via argument
    hiit = Get.arguments;
    hiit.routines
        .forEach((r) => exercises[r.exercise.id] = r.exercise.copyWith());
  }

  void updateName(String name) async {
    hiit = hiit.copyWith(name: name.trimRight());
    await workoutRepo.updateHIIT(hiit);
    update();
  }

  void onNewRoutine() {
    panelController.open(
      panel: ExerciseListScreen.component(
        exerciseController: ExerciseController(
          delegateController: this,
        ),
      ),
    );
  }

  @override
  bool exists(Exercise ex) {
    return exercises[ex.id] != null;
  }

  @override
  bool notExists(Exercise ex) {
    return exercises[ex.id] == null;
  }

  @override
  void onExerciseChanged(Exercise ex) {
    if (notExists(ex)) return;
    exercises[ex.id] = ex.copyWith();
    update();
  }

  @override
  void onExerciseRemoved(Exercise ex) {
    if (notExists(ex)) return;
    exercises.remove(ex.id);
    update();
  }

  @override
  void onExerciseSelected(Exercise ex) {
    exercises[ex.id] = ex;
    update();
  }

  @override
  void onExerciseSelectionDone() async {
    hiit = hiit.setExercises(exercises.values.toList());
    await workoutRepo.updateHIIT(hiit);
    panelController.close();
    update();
  }
}
