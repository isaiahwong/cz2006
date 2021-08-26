import 'package:fitness/app/controllers/auth/auth_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController to = Get.find();

  final AuthController authController = AuthController.to;
  final UserRepo _userRepo;

  Rxn<User> user = Rxn<User>();

  UserController({required UserRepo userRepo}) : _userRepo = userRepo;

  @override
  void onReady() async {
    ever(authController.currentAuth, handleAuthChanged);

    super.onReady();
  }

  handleAuthChanged(Auth? auth) async {
    if (auth == null) return;
    user.bindStream(_userRepo.streamUser(auth.uid));
  }
}
