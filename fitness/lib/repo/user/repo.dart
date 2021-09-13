import 'package:cloud_firestore/cloud_firestore.dart';

import 'model.dart';

class UserRepo {
  final FirebaseFirestore _store;
  late final CollectionReference collection;

  UserRepo() : _store = FirebaseFirestore.instance {
    collection = FirebaseFirestore.instance.collection('users');
  }

  Future<void> createUser(User user) async {
    return _store.doc('/users/${user.id}').set(user.toJson());
  }

  Future<User> getUser(String id) {
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
