import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model.dart';

class UserRepo {
  final FirebaseFirestore _store;

  UserRepo() : _store = FirebaseFirestore.instance;

  Future<void> createUser(User user) {
    return _store.doc('/users/${user.id}').set(user.toJson());
  }

  Future<User> getFirestoreUser(String id) {
    return _store
        .doc('/users/$id')
        .get()
        .then((documentSnapshot) => User.fromJson(documentSnapshot.data()!));
  }

  //Streams the firestore user from the firestore collection
  Stream<User> streamUser(String id) {
    return _store
        .doc('/users/$id')
        .snapshots()
        .map((snapshot) => User.fromJson(snapshot.data()!));
  }
}
