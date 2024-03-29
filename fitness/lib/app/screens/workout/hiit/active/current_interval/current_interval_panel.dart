import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/workout/hiit/active/current_interval/current_interval_duo_routine_selection.dart';
import 'package:fitness/app/screens/workout/hiit/active/current_interval/current_interval_duo_waiting.dart';
import 'package:fitness/app/screens/workout/workout.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'current_interval_panel_rest.dart';

class CurrentIntervalPanel extends GetView<ActiveHIITController> {
  Widget _nextBtn() {
    return (controller.state is ActiveWorkoutWorking)
        ? Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: controller.onIntervalCompleted,
              icon: Icon(CupertinoIcons.forward, size: 25),
              color: Colors.white,
            ),
          )
        : CustomButton(
            "SKIP",
            fontSize: 14.0,
            fontWeight: FontWeight.w900,
            textColor: Colors.white,
            backgroundColor: primaryColor,
            radius: 100,
            height: 40,
            width: 100,
            onPressed: controller.onRoutineSkip,
          );
  }

  Widget _upcomingTitle(BuildContext context) {
    final currentInterval = controller.currentInterval;
    final currentRoutine = controller.currentRoutine;

    final nextInterval =
        controller.currentRoutine?.nextInterval(current: currentInterval);
    final nextRoutine = controller.hiit.nextRoutine(currentRoutine);
    final name =
        currentRoutine?.exercise.name ?? nextRoutine?.exercise.name ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upcoming",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: red,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
        ),
        Text(
          name,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: black,
              ),
        ),
        SizedBox(width: 2),
        Text(
          "${RoutineInterval.typeToString(nextInterval?.type ?? RoutineIntervalType.UNKNOWN)} ${nextInterval?.iteration ?? ""}",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: currentInterval?.type == RoutineIntervalType.WARMUP
                    ? orange
                    : primaryColor,
              ),
        ),
      ],
    );
  }

  Widget _bottomRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _upcomingTitle(context),
          _nextBtn(),
        ],
      ),
    );
  }

  Widget _down() {
    return GestureDetector(
      onTap: () => controller.onHideFullPanel,
      child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: 40,
        height: 40,
        alignment: Alignment.topLeft,
        child: Icon(
          CupertinoIcons.chevron_down,
          color: primaryColor,
        ),
      ),
    );
  }

  List<Widget> _pages() {
    return [
      CurrentIntervalPanelWorking(),
      CurrentIntervalPanelRest(),
    ];
  }

  List<Widget> _duoWinnerPage() {
    return [
      CurrentIntervalDuoRoutineSelection(),
    ];
  }

  List<Widget> _duoPages() {
    return [
      CurrentIntervalPanelWorking(),
      CurrentIntervalDuoWaiting(),
      CurrentIntervalPanelRest(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActiveHIITController>(
      builder: (_) {
        if (controller.currentInterval == null) return SizedBox.shrink();

        return Container(
          color: lightGrey,
          width: double.infinity,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _down(),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      switch (controller.activeHIITType) {
                        case ActiveHIITType.SINGLE:
                          return _pages()[index % 2];
                        case ActiveHIITType.DUO:
                          if (controller.state is ActiveWorkoutComplete)
                            return _duoWinnerPage()[0];
                          print("index: $index");
                          return _duoPages()[index % 3];
                      }
                    },
                  ),
                ),
                _bottomRow(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
