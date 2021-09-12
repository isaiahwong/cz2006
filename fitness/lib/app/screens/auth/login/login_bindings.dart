import 'package:get/get.dart';

import 'login.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController(authRepo: Get.find()));
  }
}
