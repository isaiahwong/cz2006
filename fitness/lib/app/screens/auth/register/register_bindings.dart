<<<<<<< HEAD:fitness/lib/app/screens/auth/register_bindings.dart
import 'package:fitness/app/controllers/auth/register_controller.dart';
=======
import 'package:fitness/app/screens/auth/register/register_controller.dart';
>>>>>>> da6e8687aa811191099b3ca98501c6d642735062:fitness/lib/app/screens/auth/register/register_bindings.dart
import 'package:get/get.dart';

class RegisterUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController(authRepo: Get.find()));
  }
}
