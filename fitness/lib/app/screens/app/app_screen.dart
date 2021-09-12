import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/controllers/controllers.dart';

import 'app_screen_controller.dart';

class BaseScreen extends StatelessWidget {
  static List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.app), label: ""),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: ""),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: ""),
  ];
  static List<Widget> _screens = [
    DashboardScreen(),
    ScheduleScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppScreenController>(
      init: AppScreenController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: lightGrey,
          resizeToAvoidBottomInset: false,
          body: SlidingPanel(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _.getPageController,
              children: _screens,
            ),
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