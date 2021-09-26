import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

import 'dashboard_screen_controller.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({Key? key}) : super(key: key);

  void onWorkoutSelected(Workout workout) {
    if (workout is HIIT)
      Get.toNamed(RoutePaths.WORKOUT_DETAILS, arguments: workout.copyWith());
  }

  Widget _hiitCard({required double height, required HIIT hiit}) {
    return ColumnCard(
      height: height,
      title: hiit.name,
      subtitle: "5th May",
      statusBarTitle: "${hiit.routines.length}",
      statusBarSubtitle: "${hiit.routines.length > 1 ? "Routines" : "Routine"}",
      onTap: () => onWorkoutSelected(hiit),
    );
  }

  Widget _mapCard({required Workout workout, required double height}) {
    if (workout is HIIT) return _hiitCard(height: height, hiit: workout);
    return SizedBox.shrink();
  }

  Widget _myWorkoutsList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double height = (size.height) * 0.2;
    return GetBuilder<DashboardScreenController>(
      init: DashboardScreenController(),
      builder: (dashboardController) => Container(
        child: ReorderableWrap(
          onReorder: (int oldIndex, int newIndex) {},
          spacing: 12,
          runSpacing: 12,
          maxMainAxisCount: 2,
          children: [
            FractionallySizedBox(
              widthFactor: 0.48,
              child: ColumnCard(
                height: height,
                type: CardType.NEW_CARD,
                onTap: controller.onCreate,
              ),
            ),
            ...dashboardController.workouts
                .map(
                  (w) => FractionallySizedBox(
                    widthFactor: 0.48,
                    child: _mapCard(workout: w, height: height),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: lightGrey,
            margin: screenPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...margin(
                  children: [
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    MetricCard(
                      title: "Weight",
                      text: "68",
                      inlineText: "kg",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "My Workouts",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _myWorkoutsList(context)
                  ],
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
