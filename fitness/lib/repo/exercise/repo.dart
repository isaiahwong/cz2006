import 'package:fitness/repo/seed.dart';

import 'exercise.dart';

class ExerciseRepo {
  Future<List<Exercise>> getExercises() async {
    return exercises;
  }
}
