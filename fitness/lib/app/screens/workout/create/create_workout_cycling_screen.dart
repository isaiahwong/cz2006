import 'package:fitness/app/theme/theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateWorkoutCyclingScreen extends GetView<CreateWorkoutController> {
  static Page page() =>
      CupertinoPage<void>(child: CreateWorkoutCyclingScreen());

  const CreateWorkoutCyclingScreen({Key? key}) : super(key: key);

  void goBack(BuildContext context) {
    context
        .flow<CreateWorkoutRoute>()
        .update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: screenPadding.copyWith(top: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.chevron_back),
                  onTap: () => goBack(context),
                ),
                SizedBox(width: 20),
                Text(
                  "Cycling Path",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: darkGrey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(color: lightGrey),
        ],
      ),
    );
  }
}
