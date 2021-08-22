import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';

import 'model.dart';

class UserRepo {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _store;

  UserRepo()
      : _auth = auth.FirebaseAuth.instance,
        _store = FirebaseFirestore.instance;

  // Firebase user one-time fetch
  Future<auth.User> get getUser async => _auth.currentUser!;
  Stream<auth.User?> get user => _auth.authStateChanges();

  Future<void> register({
    required String email,
    required String password,
    required String name,
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

    // Firebase Store
    _createUserFirestore(newUser);
  }

  Future<void> _createUserFirestore(User user) {
    return _store.doc('/users/${user.id}').set(user.toJson());
  }

  Future<User> getFirestoreUser(String id) {
    return _store
        .doc('/users/$id')
        .get()
        .then((documentSnapshot) => User.fromJson(documentSnapshot.data()!));
  }

  Stream<User?> onAuthChanged() {
    return _auth.authStateChanges().asyncMap<User?>((fireUser) async {
      if (fireUser == null) return null;
      return getFirestoreUser(fireUser.uid);
    });
  }

  //Streams the firestore user from the firestore collection
  Stream<User> streamUser(String id) {
    return _store
        .doc('/users/$id')
        .snapshots()
        .map((snapshot) => User.fromJson(snapshot.data()!));
  }
}
