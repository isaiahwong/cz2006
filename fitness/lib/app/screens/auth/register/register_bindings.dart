import 'package:fitness/app/screens/auth/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(authRepo: Get.find()));
  }
}
