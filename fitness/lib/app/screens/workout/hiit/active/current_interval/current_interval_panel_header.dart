// import 'package:fitness/bloc/ui/app_panel/app_panel.dart';
import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/timer/timer_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/common/format.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentIntervalPanelHeader extends GetView<ActiveHIITController> {
  const CurrentIntervalPanelHeader({Key? key}) : super(key: key);

  Widget restWorkoutBar(BuildContext context) {
    if (controller.currentInterval == null) return SizedBox.shrink();
    final next = controller.currentRoutine
        ?.nextInterval(current: controller.currentInterval);
    final nextRoutine = controller.hiit.nextRoutine(controller.currentRoutine);
    final name = controller.currentRoutine?.exercise.name ??
        nextRoutine?.exercise.name ??
        "";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
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
              "${RoutineInterval.typeToString(next?.type)} ${next?.iteration ?? ""}",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: controller.currentInterval!.type ==
                            RoutineIntervalType.WARMUP
                        ? orange
                        : primaryColor,
                  ),
            ),
          ],
        ),
        GetBuilder<TimerController>(
          init: controller.timerController,
          builder: (timerController) {
            return Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${zeroPrefix(timerController.current.inMinutes)}:",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    Text(
                      zeroPrefix(timerController.current.inSeconds),
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                CustomButton(
                  "SKIP",
                  fontSize: 12.0,
                  fontWeight: FontWeight.w900,
                  textColor: Colors.white,
                  backgroundColor: primaryColor,
                  radius: 100,
                  height: 30,
                  width: 80,
                  onPressed: controller.onRoutineSkip,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget activeWorkoutBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.currentRoutine?.exercise.name ?? "",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
            ),
            Text(
              "${RoutineInterval.typeToString(controller.currentInterval!.type)} ${controller.currentInterval!.iteration}",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: controller.currentInterval!.type ==
                            RoutineIntervalType.WARMUP
                        ? orange
                        : primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: controller.onIntervalCompleted,
            icon: Icon(CupertinoIcons.forward, size: 20),
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _mapStateBar(BuildContext context) {
    if (controller.state is ActiveWorkoutWorking)
      return activeWorkoutBar(context);
    else if (controller.state is ActiveWorkoutRest)
      return restWorkoutBar(context);
    else
      return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActiveHIITController>(
      builder: (_) {
        if (controller.currentInterval == null) return SizedBox.shrink();
        return Stack(children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => controller.onOpenFullPanel(),
            onLongPressStart: (_) => controller.onOpenFullPanel(),
            child: Container(
              color: Colors.white,
              height: 80,
              width: double.infinity,
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 12),
              child: _mapStateBar(context),
            ),
          ),
          // SlideIndicator(),
        ]);
      },
    );
  }
}
