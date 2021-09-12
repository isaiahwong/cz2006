import 'package:fitness/repo/auth/auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthRepo authRepo = Get.find();

  Future<void> logout() async {
    return authRepo.logout();
  }
}
