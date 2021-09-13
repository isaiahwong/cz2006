import 'package:fitness/common/common.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/model.dart';

final workouts = [
  Workout(
    id: genRandStr(5),
    name: "Chest Workout",
  )
];

final chestExercises = [
  Exercise(
    id: genRandStr(5),
    name: "Bench Press",
    defaultWarmups: 2,
    defaultSets: 4,
    defaultReps: 8,
    defaultRestDuration: 120,
  ),
  Exercise(
    id: genRandStr(5),
    name: "Inclined Bench Press ",
    defaultWarmups: 2,
    defaultSets: 4,
    defaultReps: 8,
    defaultRestDuration: 120,
  ),
  Exercise(
    id: genRandStr(5),
    name: "Chest Flies",
    defaultWarmups: 2,
    defaultSets: 4,
    defaultReps: 8,
    defaultRestDuration: 120,
  ),
];

final exercises = [
  ...chestExercises,
];
