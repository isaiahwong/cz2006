import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:fitness/repo/auth/auth.dart';
import 'package:fitness/repo/user/model.dart';
import 'package:fitness/repo/user/repo.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  final firebaseAuth.FirebaseAuth _auth;
  final UserRepo _userRepo;
  final VoidCallback? initWhenAuth;
  bool _init = false;

  AuthRepo({required UserRepo userRepo, this.initWhenAuth})
      : _auth = firebaseAuth.FirebaseAuth.instance,
        _userRepo = userRepo;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required int dateOfBirth,
    String? localImagePath,
  }) async {
    // Firebase Auth
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = cred.user!;
    final newUser = User(
      id: user.uid,
      email: user.email!,
      name: name,
      dateOfBirth: dateOfBirth,
    );
    _userRepo.createUser(newUser);
    if (localImagePath != null) {
      var url = await _userRepo.uploadProfileImage(newUser.id, localImagePath);
      print("Url: ${url}");
      await _userRepo.updateUserField({"profilePicture": url});
    }
    return;
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Stream<Auth?> onAuthChanged() {
    return _auth.authStateChanges().asyncMap<Auth?>((fireUser) async {
      if (fireUser == null) return null;
      _userRepo.id = fireUser.uid;
      if (!_init && initWhenAuth != null) initWhenAuth!();
      return Auth(uid: fireUser.uid);
    });
  }
}
