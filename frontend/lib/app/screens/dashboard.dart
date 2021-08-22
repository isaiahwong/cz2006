import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:frontend/app/screens/screens.dart';
import 'package:frontend/app/controllers/controllers.dart';

class Dashboard extends StatelessWidget {
  static List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Screen 1"),
    BottomNavigationBarItem(icon: Icon(Icons.feed), label: "Screen 2"),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
  ];
  static List<Widget> _screens = [
    Screen1(),
    Screen2(),
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
