import 'package:fitness/common/common.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/workout.dart';

final workouts = [
  Workout(
    id: genRandStr(5),
    name: "Chest Workout",
  )
];

final legExercises = [
  Exercise(
    id: genRandStr(5),
    name: "Squats",
    defaultWarmups: 0,
    defaultSets: 3,
    defaultReps: 10,
    defaultRestDuration: 30,
  ),
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
  ...legExercises,
];
