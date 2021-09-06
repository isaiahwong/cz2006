import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  Rx<PageController> _pageController = PageController().obs;
  Rx<int> _currentIndex = 0.obs;

  void setIndex(int value) {
    _currentIndex.value = value;
    _pageController.value.animateToPage(
      value,
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
    update();
  }

  PageController get getPageController => _pageController.value;
  int get getCurrentIndex => _currentIndex.value;
}
