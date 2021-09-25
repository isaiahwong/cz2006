import 'package:fitness/repo/repo.dart';

import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Sub collection of user
class SocialRepo {
  final FirebaseFirestore _store;
  final String userId;
  late final DocumentReference docRef;

  SocialRepo(this.userId) : _store = FirebaseFirestore.instance {
    docRef = FirebaseFirestore.instance.collection("users").doc(userId);
  }

  /// Get users from current user sub collecion
  Future<Friends> getFriends() async {
    var snapshots = await docRef.collection("social").get();
    List<User> _friends = [];
    for (var i = 0; i < snapshots.docs.length; i++) {
      _friends.add(User.fromJson(snapshots.docs[i].data()));
    }
    return Friends(_friends);
  }

  // TODO: Add send friend request
}
