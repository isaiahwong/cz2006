import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/screens/workout/active_workout_bindings.dart';
import 'package:flutter/material.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/workout/push_screen.dart';
import 'package:fitness/app/controllers/controllers.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:get/get.dart';

class WorkoutScreen extends StatelessWidget {
  final UserController userController = UserController.to();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutScreenController>(
      init: WorkoutScreenController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: lightGrey,
          body: Container(
            padding: screenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dashboard", style: Theme.of(context).textTheme.headline1),
                // Container(
                //   child: Text("Welcome " + userController.user.value!.name,
                //       style: Theme.of(context).textTheme.headline2),
                // ),
                Container(
                  width: Get.width,
                  decoration: boxDecorationRadius.copyWith(
                    borderRadius: allBorderRadius,
                  ),
                  child: Text("Hi there"),
                ),
                Text(
                  "My Workouts",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Container(
                  padding: componentPadding,
                  decoration: boxDecorationRadius.copyWith(
                    borderRadius: allBorderRadius,
                  ),
                  width: (Get.width - 12) / 2,
                  height: (Get.width - 12) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Heading 1",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "Sub heading",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Location 1",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            "Source",
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      Text(
                        "Category",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => SecondaryScreen.Screen(),
                        binding: ActiveWorkoutBindings()),
                    child: Text("Next screen"),
                  ),
                ),
                Spacer(flex: 1),
              ],
            ),
          ),
        );
      },
    );
  }
}
