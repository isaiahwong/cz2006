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
          padding: EdgeInsets.only(top: 10),
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

  Widget _people(User user) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _peopleRow() {
    return SliverToBoxAdapter(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisCount: 5,
        children: controller.users.map<Widget>((u) => _people(u)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).userGestureInProgress,
      child: GetBuilder<WaitingRoomController>(
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  _appBar(context),
                  _peopleRow(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
