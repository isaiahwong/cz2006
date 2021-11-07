import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/screens/workout/room/waiting_room_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitingRoomScreen extends GetView<WaitingRoomController> {
  const WaitingRoomScreen({Key? key}) : super(key: key);

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 100.0,
      backgroundColor: Colors.transparent,
      leading: SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        CupertinoIcons.chevron_back,
                        size: 30,
                      ),
                      color: primaryColor,
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Waiting\nRoom",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: black,
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                ),
          ),
          _publicWorkoutSwitch()
        ]),
      ),
    );
  }

  Widget _peopleRow(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding.copyWith(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Joined",
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(color: black),
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 6,
                childAspectRatio: 0.5,
                children: controller.users
                    .map<Widget>((u) => Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: UserImage(user: u),
                            ),
                            // IconButton(
                            //   icon: Icon(CupertinoIcons.add_circled),
                            //   onPressed: () =>
                            //       controller.notifyIntiveUserSnippet(u),
                            // )
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _publicWorkoutSwitch() {
    return Column(
      children: [
        Text(
          "Public",
          style: Get.theme.textTheme.headline6!.copyWith(color: black),
        ),
        CupertinoSwitch(
          activeColor: primaryColor,
          value: controller.isPublic,
          onChanged: (value) => controller.togglePublicSwitch(value),
        ),
      ],
    );
  }

  Widget _pendingRow(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding.copyWith(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Invites",
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(color: black),
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 6,
                childAspectRatio: 0.5,
                children: controller.pendingFriends
                    .map<String, Widget>((s, u) => MapEntry(
                        s,
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: UserImage(user: u.friend),
                            ),
                            IconButton(
                              icon: Icon(CupertinoIcons.add_circled),
                              onPressed: () => controller.notifyIntive(u),
                            )
                          ],
                        )))
                    .values
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _control(BuildContext context) {
    if (controller.waitingRoomType == WaitingRoomType.INVITEE)
      return SizedBox.shrink();

    final width = MediaQuery.of(context).size.width * 0.45;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          "ADD FRIENDS",
          onPressed: controller.onViewFriends,
          backgroundColor: green,
          textColor: Colors.white,
          radius: 100,
          width: width,
        ),
        CustomButton(
          "START",
          backgroundColor: primaryColor,
          textColor: Colors.white,
          radius: 100,
          width: width,
          onPressed: controller.onStartPressed,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).userGestureInProgress,
      child: GetBuilder<WaitingRoomController>(
        builder: (controller) {
          return SlidingPanel(
            tag: RoutePaths.HIIT_WAITING_ROOM,
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: ScrollController(),
                      slivers: [
                        _appBar(context),
                        _title(context),
                        SliverToBoxAdapter(child: SizedBox(height: 30)),
                        _peopleRow(context),
                        if (controller.workout.host ==
                            UserController.get().user.value!.id)
                          _pendingRow(context),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _control(context),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
