import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/exercise/exercise_delegate.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

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

class CreateWorkoutController extends GetxController with ExerciseDelegate {
  final FlowController<CreateWorkoutRoute> flowController =
      FlowController(CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  final panelController = SlidingPanelController.get(RoutePaths.APP);
  final WorkoutRepo repo = WorkoutRepo.get();

  WorkoutName name;
  WorkoutType type;
  FormzStatus status;

  @override
  Map<String, Exercise> exercises = {};
  Map<String, Coordinates> coordinates = {};

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
    panelController.close();
    update();
  }

  void onSubmit() async {
    status = FormzStatus.submissionInProgress;
    panelController.close();

    final workoutIncrement = 0;
    final workout;
    // Create initial workout
    if (this.type == WorkoutType.HIIT) {
      workout = await repo.createWorkout(HIIT(
        name: name.value.isNotEmpty
            ? name.value
            : WorkoutName.dirty("Workout $workoutIncrement").value,
      ));
    } else {
      workout = await repo.createWorkout(Cycling(
        name: name.value.isNotEmpty
            ? name.value
            : WorkoutName.dirty("Workout $workoutIncrement").value,
      ));
    }

    switch (this.type) {
      case WorkoutType.HIIT:
        createHIIT(workout);
        return;
      case WorkoutType.CYCLING:
        createCycling(workout);
        return;
      case WorkoutType.UNKNOWN:
        print("UNKNOWN WorkoutType");
        return;
    }
  }

  Future<void> createHIIT(Workout workout) async {
    if (exercises.isEmpty) return;
    repo.updateHIIT(
      HIIT.fromWorkout(workout: workout).setExercises(
            exercises.values.toList(),
          ),
    );
    return;
  }

  Future<void> createCycling(Workout workout) async {
    if (coordinates.isEmpty) return;
    repo.updateCycling(
      Cycling.fromWorkout(workout: workout).setCoordinates(
        coordinates.values.toList(),
      ),
    );
    return;
  }

  onNameChanged(String workoutName) {
    name = WorkoutName.dirty(workoutName);
    status = Formz.validate([name]);
    update();
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
  void onExerciseSelectionDone() {
    flowController.update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  }

  void onTypeChanged(WorkoutType type) {
    this.type = type;
    update();
  }
}
