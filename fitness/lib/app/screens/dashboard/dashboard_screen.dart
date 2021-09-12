import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/workout/create/create.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reorderables/reorderables.dart';

import 'dashboard_screen_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  void onCreate() {
    final slide = SlidingPanelController.to;
    slide.open(panel: CreateWorkoutScreen.to());
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
            // ...state.workouts.map(
            //   (w) => FractionallySizedBox(
            //     widthFactor: 0.48,
            //     child: ColumnCard(
            //       height: height,
            //       title: w.name,
            //       subtitle: "5th May",
            //       statusBarTitle: "${w.exercises.length}",
            //       statusBarSubtitle: "Exercises",
            //       onTap: () => {},
            //     ),
            //   ),
            // ),
            FractionallySizedBox(
              widthFactor: 0.48,
              child: ColumnCard(
                height: height,
                type: CardType.NEW_CARD,
                onTap: onCreate,
              ),
            ),
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
