import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CurrentIntervalRepsPanel extends GetView<ActiveHIITController> {
  const CurrentIntervalRepsPanel({Key? key}) : super(key: key);

  void _onRepsChanged({
    required BuildContext context,
    required RoutineInterval interval,
    required int reps,
  }) {
    // BlocProvider.of<ActiveWorkoutBloc>(context).add(
    //   ActiveWorkoutRepUpdated(
    //     reps: reps,
    //     routine: routine,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActiveHIITController>(
      builder: (controller) => Container(
        padding: screenPadding.copyWith(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${controller.currentInterval!.currentLog.reps} Reps",
                  style: Theme.of(context).textTheme.headline5,
                ),
                CustomButton(
                  "DONE",
                  height: 25,
                  width: 70,
                  radius: 20,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  onPressed: controller.onSlidingPanelClose,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: NumberScroller(
                width: MediaQuery.of(context).size.width - 20,
                height: 300,
                initialValue: controller.currentInterval!.currentLog.reps,
                fontSize: 30,
                maxValue: 99,
                itemExtent: 40,
                onChanged: (reps) => _onRepsChanged(
                  context: context,
                  interval: controller.currentInterval!,
                  reps: reps,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
