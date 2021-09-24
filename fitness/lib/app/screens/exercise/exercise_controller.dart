import 'package:fitness/app/screens/workout/workout_controller.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/exercise/repo.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  late final ExerciseRepo exerciseRepo;
  late WorkoutController workoutController;

  List<Exercise> filteredExercises = [];

  List<Exercise> exercises = [];

  factory ExerciseController.to() {
    return Get.find();
  }

  ExerciseController({
    ExerciseRepo? exerciseRepo,
    required this.workoutController,
    List<Exercise>? selected,
  }) {
    this.exerciseRepo = exerciseRepo == null ? Get.find() : ExerciseRepo();
  }

  @override
  void onInit() async {
    super.onInit();
    exercises = await exerciseRepo.getExercises();
    exercises = List.from(exercises)
      ..map((e) =>
          workoutController.exists(e) ? workoutController.exercises[e.id] : e);
    filteredExercises = List.from(exercises);
    update();
  }

  bool isSelected(Exercise ex) {
    return workoutController.exists(ex);
  }

  void onFilter(String query) {
    /// Returns all items if query is empty
    if (query.isEmpty) {
      filteredExercises = List.from(exercises);
      update();
      return;
    }
    filteredExercises = List<Exercise>.from(exercises)
        .where((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  void onChanged({
    required Exercise exercise,
    int? seconds,
    int? minutes,
    int? sets,
    int? warmups,
    int? reps,
  }) {
    if (!isSelected(exercise)) return;
    workoutController.onExerciseChanged(
      exercise.copyWith(
        defaultReps: reps,
        defaultSets: sets,
        defaultWarmups: warmups,
        defaultRestDuration: (minutes ?? exercise.defaultRestMinutes * 60) +
            (seconds ?? exercise.defaultRestSeconds),
      ),
    );
    update();
  }

  Exercise? onSelected(Exercise ex) {
    if (isSelected(ex)) return workoutController.exercises[ex.id];
    workoutController.onExerciseSelected(ex);
    update();
    return ex;
  }

  void onRemove(Exercise ex) {
    if (!isSelected(ex)) return;
    workoutController.onExerciseRemoved(ex);
    update();
  }
}
