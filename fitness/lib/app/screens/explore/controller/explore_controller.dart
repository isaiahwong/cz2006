import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controls the social interaction of the app
class ExploreController extends GetxController {
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  Rx<int> _tabIndex = Rx<int>(0);

  int get getTabIndex => _tabIndex.value;

  set tabIndex(int value) {
    print("value: $value");
    _tabIndex.value = value;
    pageController.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
  }
}
