import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

abstract class WorkoutController extends GetxController {
  Map<String, Exercise> exercises = {};
  void onExerciseSelected(Exercise ex);
  void onExerciseRemoved(Exercise ex);
  void onExerciseChanged(Exercise ex);
  void onExercisesChanged(List<Exercise> exercises);
  void onTypeChanged(WorkoutType type);
  bool exists(Exercise ex);
  bool notExists(Exercise ex);
}
