import 'package:get/get.dart';

/// Controls the social interaction of the app
class ExploreController extends GetxController {
  Rx<int> _tabIndex = Rx<int>(0);

  int get getTabIndex => _tabIndex.value;

  set tabIndex(int value) {
    print("value: $value");
    _tabIndex.value = value;
    update();
  }
}
