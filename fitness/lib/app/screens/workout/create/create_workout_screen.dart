import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/workout/create/create_workout_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

part 'create_workout_main_screen.dart';
part 'create_workout_type_screen.dart';

class CreateWorkoutScreen extends StatefulWidget {
  final NavigatorObserver? observer;
  final CreateWorkoutController controller;

  static List<Page> router(CreateWorkoutRoute state, List<Page> pages) {
    switch (state) {
      case CreateWorkoutRoute.NEW_WORKOUT_EXERCISE:
        return [
          CreateWorkoutMainScreen.page(),
          // ExerciseListView.page(),
        ];
      case CreateWorkoutRoute.NEW_WORKOUT_TYPE:
        return [
          CreateWorkoutMainScreen.page(),
          CreateWorkoutTypeScreen.page(),
        ];
      default:
        return [CreateWorkoutMainScreen.page()];
    }
  }

  factory CreateWorkoutScreen.to() {
    return CreateWorkoutScreen(controller: CreateWorkoutController());
  }

  CreateWorkoutScreen({this.observer, required this.controller});

  // static Widget bloc(BuildContext context, {NavigatorObserver? observer}) {
  //   final workoutRepo = RepositoryProvider.of<WorkoutRepo>(context);
  //   final workoutsBloc = BlocProvider.of<WorkoutsBloc>(context);

  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (_) => WorkoutBloc(
  //           workoutRepo: workoutRepo,
  //           workoutsBloc: workoutsBloc,
  //         ),
  //       ),
  //       BlocProvider(
  //         create: (_) => ExercisesFilteredBloc(
  //           workoutRepo: workoutRepo,
  //           workoutsBloc: workoutsBloc,
  //         )..add(ExercisesRetrieved()),
  //       )
  //     ],
  //     child: CreateWorkoutScreen(
  //       observer: observer,
  //     ),
  //   );
  // }

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
            state: workoutController.route,
            onGeneratePages: (state, pages) =>
                CreateWorkoutScreen.router(state, pages),
            // Observers when screen pops.
            observers: _observers,
          ),
        ),
      ),
    ]);
  }
}
