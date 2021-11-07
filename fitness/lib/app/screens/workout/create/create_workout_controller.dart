import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/cycling/coordinates_delegate.dart';
import 'package:fitness/app/screens/exercise/exercise_delegate.dart';
import 'package:fitness/app/screens/friends/friends_delegate.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/repo/cycling/coordinates_model.dart';
import 'package:fitness/repo/cycling/coordinates_repo.dart';
import 'package:fitness/repo/exercise/exercise.dart';
import 'package:fitness/repo/social/model.dart';
import 'package:fitness/repo/social/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

enum CreateWorkoutRoute {
  NEW_WORKOUT_MAIN,
  NEW_WORKOUT_TYPE,
  NEW_WORKOUT_EXERCISE,
  NEW_WORKOUT_CYCLING_PATHS,
  PARTICIPANTS,
}

enum NewWorkoutError { TOO_LONG, TOO_SHORT }

// Validation Field Class
class WorkoutName extends FormzInput<String, NewWorkoutError> {
  const WorkoutName.pure() : super.pure('');
  const WorkoutName.dirty([String value = '']) : super.dirty(value);

  @override
  NewWorkoutError? validator(String value) {
    if (value.length > 20) {
      return NewWorkoutError.TOO_LONG;
    }
    if (value.length > 0 && value.length < 3) {
      return NewWorkoutError.TOO_SHORT;
    }
    return null;
  }
}

class CreateWorkoutController extends GetxController
    with ExerciseDelegate, CoordinatesDelegate, FriendsDelegate {
  final FlowController<CreateWorkoutRoute> flowController =
      FlowController(CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  final panelController = SlidingPanelController.get(RoutePaths.APP);
  final WorkoutRepo repo = WorkoutRepo.get();
  final CoordinatesRepo coordinateRepo = CoordinatesRepo();

  late WorkoutName name;
  late WorkoutType type;
  late FormzStatus status;
  late bool invalidCoordinate = false;

  @override
  final int friendsLimit = 10;

  @override
  Map<String, Exercise> exercises = {};
  Map<String, Coordinates> coordinates = {};
  Map<String, Friend> pendingFriends = {};

  @override
  void onInit() {
    super.onInit();
    this.type = WorkoutType.HIIT;
    this.name = const WorkoutName.pure();
    this.status = FormzStatus.pure;
  }

  close() {
    panelController.close();
    update();
  }

  void onSubmit() async {
    if (!name.valid || status.isSubmissionInProgress) {
      update();
      return;
    }
    status = FormzStatus.submissionInProgress;

    final workoutIncrement = 0;
    final Workout workout;

    // Create initial workout
    if (this.type == WorkoutType.HIIT) {
      workout = await repo.createWorkout(HIIT(
          host: UserController.get().user.value!.id,
          name: name.value.isNotEmpty
              ? name.value
              : WorkoutName.dirty("Workout $workoutIncrement").value,
          participants: pendingFriends.values
              .map((e) => UserSnippet(
                  e.friend.id, e.friend.name, e.friend.profilePicture))
              .toList()));
    } else {
      if (coordinates.isEmpty || coordinates.length != 2) {
        invalidCoordinate = true;
        update();
        status = FormzStatus.submissionFailure;
        return;
      }
      workout = await repo.createWorkout(Cycling(
          host: UserController.get().user.value!.id,
          name: name.value.isNotEmpty
              ? name.value
              : WorkoutName.dirty("Workout $workoutIncrement").value,
          participants: pendingFriends.values
              .map((e) =>
                  UserSnippet(e.id, e.friend.name, e.friend.profilePicture))
              .toList()));
    }

    panelController.close();
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
    if (coordinates.isEmpty || coordinates.length != 2) return;
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
  bool exerciseExists(Exercise ex) {
    return exercises[ex.id] != null;
  }

  @override
  bool exerciseNotExists(Exercise ex) {
    return exercises[ex.id] == null;
  }

  @override
  void onExerciseSelected(Exercise ex) {
    exercises[ex.id] = ex;
    update();
  }

  @override
  void onExerciseRemoved(Exercise ex) {
    if (exerciseNotExists(ex)) return;
    exercises.remove(ex.id);
    update();
  }

  @override
  void onExerciseChanged(Exercise ex) {
    if (exerciseNotExists(ex)) return;
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

  //CoordinatesDelegate

  @override
  void onCoordinatesSelected(Coordinates c) {
    coordinates[c.id] = c;
    invalidCoordinate = false;
    update();
  }

  @override
  void onCoordinatesRemoved(Coordinates c) {
    if (coordsNotExists(c)) return;
    coordinates.remove(c.id);
    update();
  }

  @override
  void onCoordinatesChanged(Coordinates c) {
    if (coordsNotExists(c)) return;
    coordinates[c.id] = c.copyWith();
    update();
  }

  @override
  bool coordsExists(Coordinates c) {
    return coordinates[c.id] != null;
  }

  @override
  bool coordsNotExists(Coordinates c) {
    return coordinates[c.id] == null;
  }

  @override
  void onCoordinatesSelectionDone() {
    flowController.update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  }

  @override
  bool friendExists(Friend ex) {
    return pendingFriends[ex.friend.id] != null;
  }

  @override
  bool friendNotExists(Friend ex) {
    return pendingFriends[ex.friend.id] == null;
  }

  @override
  void onFriendsChanged(Friend ex) {
    if (friendNotExists(ex)) return;
    pendingFriends[ex.friend.id] = ex.copyWith();
    update();
  }

  @override
  void onFriendsRemoved(Friend ex) {
    if (friendNotExists(ex)) return;
    pendingFriends.remove(ex.friend.id);
    update();
  }

  @override
  void onFriendsSelected(Friend ex) async {
    pendingFriends[ex.friend.id] = ex;
    // await workoutRepo.notifyInvite(ex.friend, workout);
    update();
  }

  @override
  void onFriendsSelectionDone() {
    flowController.update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
    update();
  }
}
