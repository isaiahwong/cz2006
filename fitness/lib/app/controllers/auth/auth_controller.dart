import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  // final UserRepo _userRepo;
  final AuthRepo _authRepo;

  Rxn<Auth> currentAuth = Rxn<Auth>();
  // Rxn<User> currentUser = Rxn<User>();

  AuthController({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  void onReady() async {
    //run every time auth state changes
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
