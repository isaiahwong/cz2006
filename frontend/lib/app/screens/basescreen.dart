import 'package:flutter/material.dart';
import 'package:frontend/app/screens/diet/diet_screen.dart';
import 'package:get/get.dart';

import 'package:frontend/app/screens/screens.dart';
import 'package:frontend/app/controllers/controllers.dart';

class BaseScreen extends StatelessWidget {
  static List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Workout"),
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Schedule"),
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Diet"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Me"),
  ];
  static List<Widget> _screens = [
    WorkoutScreen(),
    ScheduleScreen(),
    DietScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (_) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _.getPageController,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _.getCurrentIndex,
            onTap: (value) => _.setIndex(value),
            items: _barItems,
          ),
        );
      },
    );
  }
}
