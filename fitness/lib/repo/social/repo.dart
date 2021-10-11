import 'package:cloud_functions/cloud_functions.dart';
import 'package:fitness/repo/repo.dart';

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

  /// Find users based on name field
  Future<List<User>> findUsers(String name) async {
    var snapshot = await _store
        .collection("users")
        .where("id", isNotEqualTo: userId)
        .where("name", isEqualTo: name)
        .get();
    List<User> _users = [];
    for (var i = 0; i < snapshot.docs.length; i++) {
      _users.add(User.fromJson(snapshot.docs[i].data()));
    }
    return _users;
  }

  /// Get users from current user sub collecion
  Future<List<Friend>> getFriends() async {
    var snapshots = await docRef
        .collection("friends")
        .where("status", isEqualTo: SocialStatus.FRIEND.toString())
        .get();
    List<Friend> _friends = [];
    for (var i = 0; i < snapshots.docs.length; i++) {
      _friends.add(Friend.fromJson(snapshots.docs[i].data()));
    }
    return _friends;
  }

  /// Get user's friend in stream
  Stream<List<Friend>> streamFriends() {
    return docRef
        .collection("friends")
        .where("status", isEqualTo: "FRIEND")
        .limit(10)
        .snapshots(includeMetadataChanges: false)
        .map((event) {
      List<Friend> _friends = [];
      for (int i = 0; i < event.docs.length; i++) {
        _friends.add(Friend.fromJson(event.docs[i].data()));
      }
      return _friends;
    });
  }

  /// Get all the request from collection
  Future<List<Friend>> getRequests() async {
    var snapshots = await docRef
        .collection("friends")
        .where("responder.id", isEqualTo: userId)
        .where("status", isEqualTo: SocialStatus.PENDING.toString())
        .get();

    List<Friend> _requests = [];

    /// Parse to usersnippet
    for (var i = 0; i < snapshots.docs.length; i++) {
      _requests.add(Friend.fromJson(snapshots.docs[i].data()));
    }

    print("Number of friend requests: ${_requests.length}");
    return _requests;
  }

  /// Stream version of friend requests
  Stream<List<Friend>> streamRequest() {
    return docRef
        .collection("friends")
        .limit(10)
        .where("responder.id", isEqualTo: userId)
        .where("status", isEqualTo: "PENDING")
        .snapshots(includeMetadataChanges: true)
        .map((event) {
      print("Friend requests: ${event.docs.length}");
      List<Friend> _friends = [];
      for (int i = 0; i < event.docs.length; i++) {
        print(event.docs[i].data());
        _friends.add(Friend.fromJson(event.docs[i].data()));
      }
      return _friends;
    });
  }

  /// - Cloud Functions HTTPS callable
  /// Send request to user
  Future<void> sendRequest(String responderId) async {
    print("Initiator id: ${userId} && responderId: ${responderId}");

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

  /// Select userId with response, either accept or decline
  Future<void> respondRequest(
    String userId,
    String documentId,
    bool response,
  ) async {
    try {
      await _functions.httpsCallable("social-respondRequest").call({
        "friendId": userId,
        "documentId": documentId,
        "response": response,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// Fetch user document based on given id
  /// - Assume user exists
  Future<User> getUser(String userId) async {
    var result = await _store.collection("users").doc(userId).get();
    User user = User.fromJson(result.data()!);
    return user;
  }

  /// Invite friend to workout
  Future<void> inviteWorkout(
    String workoutId,
  ) async {}
}
