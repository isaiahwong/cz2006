import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/app/app_screen_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fitness/app/screens/screens.dart';

class AppScreen extends GetView<AppScreenController> {
  static List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.app), label: ""),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar), label: ""),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: ""),
  ];

  static List<Widget> _screens = [
    DashboardScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SlidingPanel(
      tag: RoutePaths.APP,
      child: Scaffold(
        backgroundColor: lightGrey,
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: controller.getPageController,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.getCurrentIndex,
          onTap: (value) => controller.setIndex(value),
          items: _barItems,
        ),
      ),
    );
  }
}
