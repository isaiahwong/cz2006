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

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Stream<Auth?> onAuthChanged() {
    return _auth.authStateChanges().asyncMap<Auth?>((fireUser) async {
      if (fireUser == null) return null;
      return Auth(uid: fireUser.uid);
    });
  }
}
