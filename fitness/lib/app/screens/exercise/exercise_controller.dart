import 'package:fitness/repo/exercise/repo.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  final ExerciseRepo exerciseRepo;

  List<Exercise> filteredExercises = [];
  List<Exercise> exercises = [];

  ExerciseController({required this.exerciseRepo});

  @override
  void onInit() async {
    super.onInit();
    exercises = await exerciseRepo.getExercises();
    filteredExercises = List.from(exercises);
    // print('show post return value: $posts');
  }
}
