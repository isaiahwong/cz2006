import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/screens/cycling/coordinates_controller.dart';
import 'package:fitness/app/screens/exercise/exercise_controller.dart';
import 'package:fitness/app/screens/friends/friends_controller.dart';
import 'package:fitness/app/screens/friends/friends_list_screen.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/cycling/coordinates.dart';
import 'package:fitness/app/screens/workout/create/create_workout_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

part 'create_workout_main_screen.dart';
part 'create_workout_type_screen.dart';

class CreateWorkoutScreen extends StatefulWidget {
  final NavigatorObserver? observer;
  final CreateWorkoutController controller;

  List<Page> router(CreateWorkoutRoute state) {
    switch (state) {
      case CreateWorkoutRoute.NEW_WORKOUT_EXERCISE:
        return [
          CreateWorkoutMainScreen.page(),
          ExerciseListScreen.page(
            exerciseController: ExerciseController(
              delegateController: controller,
            ),
          ),
        ];
      case CreateWorkoutRoute.NEW_WORKOUT_TYPE:
        return [
          CreateWorkoutMainScreen.page(),
          CreateWorkoutTypeScreen.page(),
        ];
      case CreateWorkoutRoute.NEW_WORKOUT_CYCLING_PATHS:
        return [
          CreateWorkoutMainScreen.page(),
          CreateWorkoutCyclingScreen.page(
            coordinatesController: CoordinatesController(
              delegateController: controller,
            ),
          ),
        ];
      case CreateWorkoutRoute.PARTICIPANTS:
        return [
          CreateWorkoutMainScreen.page(),
          FriendsListScreen.page(
            friendsController:
                FriendsController(delegateController: controller),
          ),
        ];
      default:
        return [
          CreateWorkoutMainScreen.page(),
        ];
    }
  }

  factory CreateWorkoutScreen.get() {
    return CreateWorkoutScreen(controller: CreateWorkoutController());
  }

  CreateWorkoutScreen({this.observer, required this.controller});

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  late final List<NavigatorObserver> _observers;

  @override
  void initState() {
    super.initState();
    _observers = widget.observer != null ? [widget.observer!] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 1.0),
        child: GetBuilder<CreateWorkoutController>(
          init: widget.controller,
          builder: (workoutController) => FlowBuilder<CreateWorkoutRoute>(
            onGeneratePages: (state, pages) => widget.router(state),
            // Observers when screen pops.
            observers: _observers,
            controller: workoutController.flowController,
          ),
        ),
      ),
    ]);
  }
}
