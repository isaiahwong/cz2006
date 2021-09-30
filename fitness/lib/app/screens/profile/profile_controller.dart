import 'package:fitness/repo/auth/auth.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/user/model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthRepo authRepo = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    /// Fetch information about current user
    super.onReady();
  }

  Future<void> logout() async {
    return authRepo.logout();
  }
}
