import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // final UserRepo _userRepo;
  final AuthRepo _authRepo;

  Rxn<Auth> currentAuth = Rxn<Auth>();

  AuthController({required AuthRepo authRepo}) : _authRepo = authRepo;

  factory AuthController.to() {
    return Get.find();
  }

  @override
  void onReady() async {
    ever(currentAuth, handleAuthChanged);
    currentAuth.bindStream(_authRepo.onAuthChanged());

    super.onReady();
  }

  handleAuthChanged(Auth? auth) async {
    if (auth == null) {
      Get.offAllNamed(RoutePaths.LOGIN);
      return;
    }
    // if (user.uid != null) {
    //   currentUser.bindStream(_userRepo.streamUser(user.uid));
    // }
    Get.offAllNamed(RoutePaths.DASHBOARD);
  }
}
