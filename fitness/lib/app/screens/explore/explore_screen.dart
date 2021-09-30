import 'package:fitness/app/screens/explore/controller/explore_controller.dart';
import 'package:fitness/app/screens/explore/workout_screen.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Explore Screen Build");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: lightGrey,
        elevation: 1,
        title: Text(
          "Explore",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: ExploreBodyScreen(),
    );
  }
}

class ExploreBodyScreen extends StatelessWidget {
  final Map<int, Widget> _headerWidgets = {
    0: Text("Workout"),
    1: Text("Social"),
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreController>(
      init: ExploreController(),
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(8),
          height: Get.height,
          width: Get.width,
          // padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SegmentedControl(_),
              Expanded(
                child: _bodyWidgets(_),
              ),
            ],
          ),
        );
      },
    );
  }

  PageView _bodyWidgets(ExploreController _) {
    return PageView(
      controller: _.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ExploreWorkoutScreen(),
        SocialWidget(),
      ],
    );
  }

  Container SegmentedControl(ExploreController _) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: Get.width,
      child: CupertinoSegmentedControl<int>(
        groupValue: _.getTabIndex,
        children: _headerWidgets,
        selectedColor: primaryColor,
        unselectedColor: lightGrey,
        onValueChanged: (int value) {
          _.tabIndex = value;
        },
      ),
    );
  }
}