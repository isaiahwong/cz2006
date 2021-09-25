import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/workout/workout_controller.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:formz/formz.dart';

enum CreateWorkoutRoute {
  NEW_WORKOUT_MAIN,
  NEW_WORKOUT_TYPE,
  NEW_WORKOUT_EXERCISE,
}

enum NewWorkoutError {
  TOO_LONG,
}

// Validation Field Class
class WorkoutName extends FormzInput<String, NewWorkoutError> {
  const WorkoutName.pure() : super.pure('');
  const WorkoutName.dirty([String value = '']) : super.dirty(value);

  @override
  NewWorkoutError? validator(String value) {
    if (value.length > 20) {
      return NewWorkoutError.TOO_LONG;
    }
    return null;
  }
}

class CreateWorkoutController extends WorkoutController {
  CreateWorkoutRoute route = CreateWorkoutRoute.NEW_WORKOUT_MAIN;
  WorkoutName name;
  WorkoutType type;
  FormzStatus status;
  @override
  Map<String, Exercise> exercises = {};

  CreateWorkoutController({
    this.type = WorkoutType.HIIT,
    this.name = const WorkoutName.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  void onInit() {
    super.onInit();
  }

  close() {
    final panelController = SlidingPanelController.to;
    panelController.close();
    update();
  }

  void onSubmit() async {
    // Workout(
    //   name: name.value.isNotEmpty
    //       ? name.value
    //       : WorkoutName.dirty("Workout $workoutIncrement"),
    //   status: FormzStatus.submissionInProgress,
    //   exercises: exercises,
    // );
    final panelController = SlidingPanelController.to;
    panelController.close();
  }

  bool exists(Exercise ex) {
    return exercises[ex.id] != null;
  }

  bool notExists(Exercise ex) {
    return exercises[ex.id] == null;
  }

  onNameChanged(String workoutName) {
    name = WorkoutName.dirty(workoutName);
    status = Formz.validate([name]);
    update();
  }

  @override
  void onExerciseSelected(Exercise ex) {
    exercises[ex.id] = ex;
    update();
  }

  @override
  void onExerciseRemoved(Exercise ex) {
    if (notExists(ex)) return;
    exercises.remove(ex.id);
    update();
  }

  @override
  void onExerciseChanged(Exercise ex) {
    if (notExists(ex)) return;
    exercises[ex.id] = ex.copyWith();
    update();
  }

  @override
  void onExercisesChanged(List<Exercise> exercises) {
    exercises = List.from(exercises);
    update();
  }

  @override
  void onTypeChanged(WorkoutType type) {
    this.type = type;
    update();
  }
}
