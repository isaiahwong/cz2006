import 'package:frontend/app/routes/routes.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    // if (_firebaseUser?.uid != null) {
    //   firestoreUser.bindStream(streamFirestoreUser());
    // }

    if (_firebaseUser == null) {
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {}
  }

  // User registration using email and password
  registerWithEmailAndPassword() async {}
}
