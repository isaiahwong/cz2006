import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:fitness/repo/auth/auth.dart';
import 'package:fitness/repo/user/model.dart';
import 'package:fitness/repo/user/repo.dart';

class AuthRepo {
  final firebaseAuth.FirebaseAuth _auth;
  final UserRepo _userRepo;

  AuthRepo({required UserRepo userRepo})
      : _auth = firebaseAuth.FirebaseAuth.instance,
        _userRepo = userRepo;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Firebase Auth
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = cred.user!;
    final newUser = User(
      id: user.uid,
      email: user.email!,
      name: name,
    );

    return _userRepo.createUser(newUser);
  }

  Future<void> login({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() {
    return _auth.signOut();
  }

  Stream<Auth?> onAuthChanged() {
    return _auth.authStateChanges().asyncMap<Auth?>((fireUser) async {
      if (fireUser == null) return null;
      return Auth(uid: fireUser.uid);
    });
  }

  static String errorToMessage(dynamic error) {
    try {
      final e = error as firebaseAuth.FirebaseAuthException;
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          return "Your email address appears to be malformed.";

        case "ERROR_WRONG_PASSWORD":
          return "Your password is wrong.";

        case "ERROR_USER_NOT_FOUND":
          return "User with this email doesn't exist.";

        case "ERROR_USER_DISABLED":
          return "User with this email has been disabled.";

        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests. Try again later.";

        case "ERROR_OPERATION_NOT_ALLOWED":
          return "Signing in with Email and Password is not enabled.";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      return "Firebase error.";
    }
  }
}
