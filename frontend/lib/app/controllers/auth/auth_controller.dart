import 'package:frontend/app/routes/routes.dart';
import 'package:frontend/repo/user/model.dart';
import 'package:frontend/repo/user/repo.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;

class AuthController extends GetxController {
  static AuthController to = Get.find();

  UserRepo userRepo = UserRepo();

  Rxn<User> user = Rxn<User>();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(user, handleAuthChanged);

    user.bindStream(userRepo.onAuthChanged());
    super.onReady();
  }

  handleAuthChanged(User? user) async {
    //get user data from firestore
    // if (_firebaseUser?.uid != null) {
    //   firestoreUser.bindStream(streamFirestoreUser());
    // }

    if (user == null) {
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {}
  }

  // User registration using email and password
  registerWithEmailAndPassword() async {}
}
