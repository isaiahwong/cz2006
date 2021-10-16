import 'package:fitness/app/screens/explore/invitation_screen.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls the social interaction of the app
class ExploreController extends GetxController {
  PageController pageController = PageController();
  Rx<int> _tabIndex = Rx<int>(0);

  static ExploreController get to => Get.find();

  List<Widget> screens = [
    ExploreWorkoutScreen(),
    SocialScreen(),
  ];
  @override
  void onInit() {
    Get.put(SocialController(), permanent: true);
    Get.put(ExploreWorkoutController(), permanent: true);
    super.onInit();
  }

  @override
  void onClose() {
    if (!Get.find<SocialController>().isClosed) {
      Get.find<SocialController>().onClose();
    }
    if (!Get.find<ExploreWorkoutController>().isClosed) {
      Get.find<ExploreWorkoutController>().onClose();
    }
    super.onClose();
  }

  viewInvitation() async {
    await Get.bottomSheet(InvitationScreen());
  }

  int get getTabIndex {
    update();
    return _tabIndex.value;
  }

  set tabIndex(int value) {
    print("value: $value");
    _tabIndex.value = value;

    update();
  }
}
