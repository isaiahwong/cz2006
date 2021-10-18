import 'package:cloud_functions/cloud_functions.dart';
import 'package:fitness/repo/repo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';

/// Sub collection of user
class SocialRepo {
  final FirebaseFirestore _store;
  final FirebaseFunctions _functions;
  final String userId;
  late final DocumentReference userDocRef;

  SocialRepo(this.userId)
      : _store = FirebaseFirestore.instance,
        _functions = FirebaseFunctions.instanceFor(region: "asia-east2") {
    userDocRef = FirebaseFirestore.instance.collection("users").doc(userId);
  }

  static SocialRepo get to => Get.find();

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
    var snapshots = await userDocRef
        .collection("friends")
        .where("status", isEqualTo: "FRIEND")
        .get();
    List<Friend> _friends = [];
    for (var i = 0; i < snapshots.docs.length; i++) {
      _friends.add(Friend.fromJson(snapshots.docs[i].data()));
    }
    return _friends;
  }

  /// Get user's friend in stream
  Stream<List<Friend>> streamFriends() {
    return userDocRef
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
    var snapshots = await userDocRef
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
    return userDocRef
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

  /// Show available public workout (Fetch once)
  Future<List<WorkoutGroupWithId>> getPublicWorkout() async {
    var result = await _store
        .collection("workoutGroups")
        .where("public", isEqualTo: true)
        .get();
    List<WorkoutGroupWithId> _groups = [];
    for (var i = 0; i < result.size; i++) {
      _groups.add(WorkoutGroupWithId.fromJson(result.docs[i].data()));
    }
    return _groups;
  }

  /// Update list of public workout
  Stream<List<WorkoutGroupWithId>> streamPublicWorkout() {
    return _store
        .collection("workoutGroups")
        .where("public", isEqualTo: true)
        .snapshots(includeMetadataChanges: true)
        .map((event) {
      List<WorkoutGroupWithId> _workoutGroups = [];
      for (var i = 0; i < event.docs.length; i++) {
        _workoutGroups.add(WorkoutGroupWithId.fromJson(event.docs[i].data()));
      }
      return _workoutGroups;
    });
  }

  /// Show a list of workout invitation
  Future<List<WorkoutInvite>> getWorkoutInvites() async {
    var result = await _store
        .collection("users")
        .doc(userId)
        .collection("invites")
        .where("isActive", isEqualTo: true)
        .get();
    List<WorkoutInvite> _invites = [];

    for (var i = 0; i < result.size; i++) {
      _invites.add(WorkoutInvite.fromJson(result.docs[i].data()));
    }
    return _invites;
  }

  /// Function to toggle workout
  /// true to set public, false to set private
  Future<void> toggleWorkoutPublic(bool isPublic, String workoutId) async {
    /// Set isPublic workout flag from workoutGroups path
    try {
      await _store
          .collection("workoutgroups")
          .doc(workoutId)
          .update({"isPublic": isPublic});
    } catch (e) {
      print(e);
    }
  }

  /// Functin to toggle workout isActive
  Future<void> toggleWorkoutActive(bool isActive, String workoutId) async {
    await _store
        .collection("workoutgroups")
        .doc(workoutId)
        .update({"isActive": isActive});
    return;
  }

  /// Add a workout to group (allowing > 1 users)
  Future<void> createGroupWorkout(WorkoutGroup group) async {
    try {
      await _functions
          .httpsCallable("workout-createWorkoutGroup")
          .call({"workoutGroup": group.toJson()});
    } catch (e) {
      print(e.toString());
    }
  }

  /// Takes in id for workoutGroup document
  Future<ResponseMessage> joinWorkout(String workoutGroupId) async {
    var result;
    try {
      result = await _functions.httpsCallable("workout-joinWorkoutGroup").call({
        "workoutGroupId": workoutGroupId,
      });
    } catch (e) {
      print(e.toString());
    }
    return ResponseMessage.fromJson(result.data);
  }

  /// Invite user to workout session
  Future<ResponseMessage> inviteWorkout({
    required String workoutGroupId,
    required String userId,
  }) async {
    var result;
    try {
      result = await _functions.httpsCallable("workout-inviteWorkout").call({
        "workoutGroupId": workoutGroupId,
        "userId": userId,
      });
    } catch (e) {
      print(e.toString());
    }
    return ResponseMessage.fromJson(result.data);
  }

  /// Toggle workout (isActive) status
  /// e.g. When workout has ended
  Future<void> setWorkoutStatus({
    required String workoutGroupId,
    bool isActive = false,
  }) async {
    try {
      _functions.httpsCallable("workout-setWorkoutStatus").call({
        "workoutGroupId": workoutGroupId,
        "isActive": isActive,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// Fetch workout from user sub collection
  Future<dynamic> fetchWorkout({
    required String workoutId,
    required creatorId,
  }) async {
    var result = await _store
        .collection("users")
        .doc(creatorId)
        .collection("workouts")
        .doc(workoutId)
        .get();
    // Determine if exercise is cycling / HIIT
    if (!result.exists) {
      return null;
    }
    var exercsie = Workout.fromJson(result.data()!);
    if (exercsie.type == WorkoutType.CYCLING) {
      return Cycling.fromJson(result.data()!);
    }
    if (exercsie.type == WorkoutType.HIIT) {
      return HIIT.fromJson(result.data()!);
    }
    return null;
  }
}
