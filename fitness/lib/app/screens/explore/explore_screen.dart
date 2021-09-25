import 'package:fitness/app/screens/explore/explore_controller.dart';
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
      backgroundColor: grey,
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
        return Column(
          children: [
            Container(
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
            ),
          ],
        );
      },
    );
  }
}
