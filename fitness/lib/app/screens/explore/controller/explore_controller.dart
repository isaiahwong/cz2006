import 'package:fitness/app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls the social interaction of the app
class ExploreController extends GetxController {
  PageController pageController = PageController();

  static ExploreController to = Get.find();

  List<Widget> screens = [
    ExploreWorkoutScreen(),
    SocialScreen(),
  ];
  @override
  void onInit() {
    Get.put(SocialController());
    Get.put(ExploreWorkoutController());
    super.onInit();
  }

  @override
  void onClose() {
    SocialController.to.onClose();
    ExploreWorkoutController.to.onClose();
    super.onClose();
  }

  Rx<int> _tabIndex = Rx<int>(0);

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
