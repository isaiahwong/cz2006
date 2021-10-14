import 'dart:async';

import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/exercise/exercise.dart';
import 'package:fitness/app/screens/exercise/exercise_controller.dart';
import 'package:fitness/repo/exercise/model.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

class HIITDetailsController extends GetxController with ExerciseDelegate {
  late HIIT hiit;
  final WorkoutRepo workoutRepo = WorkoutRepo.get();
  late final StreamSubscription keyboardSub;
  late final TextEditingController hiitNameController;

  final SlidingPanelController panelController;

  bool editing = false;

  @override
  Map<String, Exercise> exercises = {};

  HIITDetailsController({SlidingPanelController? panelController})
      : this.panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.HIIT_DETAILS)
            : panelController;

  @override
  void onInit() {
    super.onInit();
    // Get HIIT passed via argument
    hiit = Get.arguments;
    hiit.routines
        .forEach((r) => exercises[r.exercise.id] = r.exercise.copyWith());

    hiitNameController = TextEditingController(text: hiit.name);
    keyboardSub =
        KeyboardVisibilityController().onChange.listen(onKeyboardDismiss);
  }

  @override
  void onClose() {
    keyboardSub.cancel();
    super.onClose();
  }

  void onKeyboardDismiss(bool visible) async {
    if (visible) return;
    hiit = hiit.copyWith(name: hiitNameController.text.trimRight());
    await workoutRepo.updateHIIT(hiit);
    editing = false;
    update();
  }

  void onEdit(String _) {
    editing = true;
    update();
  }

  void onSoloStart() {
    Get.toNamed(RoutePaths.HIIT_ACTIVE, arguments: [
      ActiveHIITType.SINGLE,
      hiit.copyWith(),
    ]);
  }

  void onDuoStart() {
    Get.toNamed(RoutePaths.HIIT_WAITING_ROOM, arguments: [
      WaitingRoomType.HOST,
      hiit.copyWith(),
    ]);
  }

  void onNewRoutine() {
    panelController.open(
      panel: ExerciseListScreen.component(
        exerciseController: ExerciseController(
          delegateController: this,
        ),
      ),
    );
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
  void onExerciseChanged(Exercise ex) {
    if (notExists(ex)) return;
    exercises[ex.id] = ex.copyWith();
    update();
  }

  @override
  void onExerciseRemoved(Exercise ex) {
    if (notExists(ex)) return;
    exercises.remove(ex.id);
    update();
  }

  @override
  void onExerciseSelected(Exercise ex) {
    exercises[ex.id] = ex;
    update();
  }

  @override
  void onExerciseSelectionDone() async {
    hiit = hiit.setExercises(exercises.values.toList());
    await workoutRepo.updateHIIT(hiit);
    panelController.close();
    update();
  }
}
