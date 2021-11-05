import 'package:fitness/app/screens/explore/controller/explore_controller.dart';
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
      // appBar: AppBar(
      //     centerTitle: true,
      //     backgroundColor: lightGrey,
      //     elevation: 1,
      //     title: Text(
      //       "Explore",
      //       style: Theme.of(context).textTheme.headline3,
      //     ),
      //     actions: [
      //       IconButton(
      //         onPressed: () async {
      //           await Get.find<SocialController>().fetchInvitations();
      //           Get.find<ExploreController>().viewInvitation();
      //         },
      //         icon: Icon(Icons.more_vert_outlined, color: Colors.black),
      //       )
      //     ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Friends",
              style: Theme.of(context).textTheme.headline3,
            ),
            SafeArea(child: SocialScreen()),
          ],
        ),
      ),
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
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(8),
          height: Get.height,
          width: Get.width,
          // padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SegmentedControl(_),
              Expanded(child: _.screens[_.getTabIndex]),
            ],
          ),
        );
      },
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
