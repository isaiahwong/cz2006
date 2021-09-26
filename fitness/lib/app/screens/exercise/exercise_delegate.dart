import 'package:fitness/repo/exercise/model.dart';

abstract class ExerciseDelegate {
  Map<String, Exercise> exercises = {};
  void onExerciseSelected(Exercise ex);
  void onExerciseRemoved(Exercise ex);
  void onExerciseChanged(Exercise ex);
  bool exists(Exercise ex);
  bool notExists(Exercise ex);
  void onExerciseSelectionDone();
}
