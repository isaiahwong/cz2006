import 'package:cloud_functions/cloud_functions.dart';
import 'package:fitness/repo/repo.dart';

import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Sub collection of user
class SocialRepo {
  final FirebaseFirestore _store;
  final FirebaseFunctions _functions;
  final String userId;
  late final DocumentReference docRef;

  SocialRepo(this.userId)
      : _store = FirebaseFirestore.instance,
        _functions = FirebaseFunctions.instanceFor(region: "asia-east2") {
    docRef = FirebaseFirestore.instance.collection("users").doc(userId);
  }

  /// Get users from current user sub collecion
  Future<List<User>> getFriends() async {
    var snapshots = await docRef.collection("friends").get();
    List<User> _friends = [];
    for (var i = 0; i < snapshots.docs.length; i++) {
      _friends.add(User.fromJson(snapshots.docs[i].data()));
    }
    return _friends;
  }

  /// Get all the request from collection
  Future<List<FriendRequest>> getRequests() async {
    var snapshots = await docRef
        .collection("requests")
        .where("initiator.id", isNotEqualTo: userId)
        .get();

    List<FriendRequest> _requests = [];

    /// Parse to usersnippet
    for (var i = 0; i < snapshots.docs.length; i++) {
      _requests.add(FriendRequest.fromJson(snapshots.docs[i].data()));
    }

    print("Number of friend requests: ${_requests.length}");
    return _requests;
  }

  /// - Cloud Functions HTTPS callable
  /// Send request to user
  Future<void> sendRequst(String responderId) async {
    /// Consturct a friend request
    try {
      await _functions
          .httpsCallable("social-sendRequest")
          .call({"initiatorId": userId, "responderId": responderId});
    } catch (e) {
      print(e.toString());
    }
    return;
  }

  Future<void> respondRequest(String requestId, bool response) async {
    try {
      await _functions.httpsCallable("social-respondRequest").call({
        "requestId": requestId,
        "response": response,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
