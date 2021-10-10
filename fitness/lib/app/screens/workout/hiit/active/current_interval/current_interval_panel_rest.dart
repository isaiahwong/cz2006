import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/timer/timer_controller.dart';
import 'package:fitness/app/screens/workout/timer/timer_state.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/common/format.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CurrentIntervalPanelRest extends GetView<ActiveHIITController> {
  const CurrentIntervalPanelRest({Key? key}) : super(key: key);

  static Page page() => CupertinoPage<void>(
        child: CurrentIntervalPanelRest(),
      );

  @override
  Widget build(BuildContext context) {
    final timerSize = MediaQuery.of(context).size.width * 0.8;
    return Container(
      child: GetBuilder<TimerController>(
        init: controller.timerController,
        builder: (timerController) => Align(
          child: SizedBox(
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  progressBarWidth: 25,
                  trackWidth: 25,
                ),
                customColors: CustomSliderColors(
                  progressBarColor: primaryColor,
                  trackColor: accentColor,
                  hideShadow: true,
                ),
                animationEnabled: false,
                startAngle: 270,
                angleRange: 360,
                size: timerSize,
              ),
              onChange: (d) {
                if (timerController.state is TimerPause)
                  timerController.onTimerSet(Duration(milliseconds: d.toInt()));
              },
              onChangeStart: (_) => timerController.onTimerPause(),
              onChangeEnd: (d) => timerController
                  .onTimerStart(Duration(milliseconds: d.toInt())),
              min: -0.1,
              max: Duration(
                      seconds: controller.currentInterval!.defaultRestDuration)
                  .inMilliseconds
                  .toDouble(),
              initialValue: timerController.current.inMilliseconds.toDouble(),
              innerWidget: (_) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${zeroPrefix(timerController.current.inMinutes)}:",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 50),
                  ),
                  Text(
                    zeroPrefix(timerController.seconds),
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(fontSize: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
