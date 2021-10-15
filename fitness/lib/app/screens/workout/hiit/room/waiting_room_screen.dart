import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
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
        child: Text(
          "Waiting\nRoom",
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: black,
                fontWeight: FontWeight.w900,
                fontSize: 50,
              ),
        ),
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
              height: MediaQuery.of(context).size.height * 0.4,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 6,
                children: controller.users
                    .map<Widget>((e) => UserImage(user: e))
                    .toList(),
              ),
            )
          ],
        ),
      ),
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
              "Pending Request",
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(color: black),
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                crossAxisCount: 6,
                childAspectRatio: 1,
                children: controller.pendingFriends
                    .map<String, Widget>(
                        (s, u) => MapEntry(s, UserImage(user: u.friend)))
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
          onPressed: controller.onStartHIIT,
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
                        // _pendingRow(context),
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
