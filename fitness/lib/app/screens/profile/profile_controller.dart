import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthRepo authRepo = Get.find();
  Rxn<User> user = UserController.get().user;

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
