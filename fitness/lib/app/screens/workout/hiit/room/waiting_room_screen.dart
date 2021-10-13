import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

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

  Widget _people(UserSnippet user) {
    return Container(
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        maxRadius: 10,
        backgroundImage: NetworkImage(user.profilePicture),
      ),
    );
  }

  Widget _peopleRow() {
    return SliverToBoxAdapter(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: 5,
        children: controller.friends
            .map<String, Widget>((s, u) => MapEntry(s, _people(u.friend)))
            .values
            .toList(),
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
            GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 5,
              children: controller.friends
                  .map<String, Widget>((s, u) => MapEntry(s, _people(u.friend)))
                  .values
                  .toList(),
            )
          ],
        ),
      ),
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
                        // _peopleRow(),
                        _pendingRow(context),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: controller.onViewFriends,
                        child: Icon(
                          CupertinoIcons.add,
                          size: 50,
                        ),
                      ),
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
