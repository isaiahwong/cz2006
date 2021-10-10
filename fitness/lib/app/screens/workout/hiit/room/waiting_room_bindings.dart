import 'package:get/get.dart';

import 'room.dart';

class WaitingRoomBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => WaitingRoomController());
  }
}
