import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class UserRepo {
  final FirebaseFirestore _store;
  late final CollectionReference collection;
  late final FirebaseStorage _storage;
  String _id = "";

  String get id => _id;

  set id(String id) => _id = id;

  UserRepo() : _store = FirebaseFirestore.instance {
    collection = FirebaseFirestore.instance.collection('users');
    _storage = FirebaseStorage.instance;
  }

  Future<void> createUser(User user) async {
    return _store.doc('/users/${user.id}').set(user.toJson());
  }

  /// Uploads a profile image based on the user's id
  /// Returns url string
  Future<String> uploadProfileImage(String id, String path) async {
    File _file = File(path);
    String _downloadURL = "";
    try {
      var result = await _storage.ref("/${id}/profileimage").putFile(_file);
      _downloadURL = await result.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    return _downloadURL;
  }

  /// Update current user field using key value pair
  Future<void> updateUserField(Map<String, dynamic> data) async {
    return await collection.doc(_id).update(data);
  }

  Future<User> getUser(String id) {
    return _store
        .doc('/users/$id')
        .get()
        .then((documentSnapshot) => User.fromJson(documentSnapshot.data()!));
  }

  //Streams the firestore user from the firestore collection
  Stream<User> streamUser() {
    if (_id.isEmpty) throw ErrorDescription("User id is empty. Set id first");
    return _store
        .doc('/users/$_id')
        .snapshots()
        .map((snapshot) => User.fromJson(snapshot.data()!));
  }
}
