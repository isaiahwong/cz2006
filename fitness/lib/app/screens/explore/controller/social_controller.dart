import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/explore/components/popup_dialog.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SocialController extends GetxController {
  late SocialRepo socialRepo;

  Rx<List<Friend>> _friends = Rx([]);
  Rx<List<Friend>> _requests = Rx([]);

  /// Data to display to user
  List<UserSnippet> friends = [];
  List<Friend> requests = [];

  List<User> foundUsers = [];
  List<WorkoutInvite> _workoutInvites = [];

  TextEditingController? searchTextController;

  SocialController();

  factory SocialController.get() {
    return Get.find();
  }

  @override
  void onInit() {
    socialRepo = Get.find<SocialRepo>();
    searchTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    /// Call repo
    _friends.bindStream(socialRepo.streamFriends());
    _requests.bindStream(socialRepo.streamRequest());

    ever(_friends, _friendsHandler);
    ever(_requests, _requestHandler);

    super.onReady();
  }

  @override
  void onClose() {
    if (!_friends.subject.isClosed) {
      _friends.close();
    }
    if (!_requests.subject.isClosed) {
      _requests.close();
    }

    super.onClose();
  }

  /// Handler to filter friends
  _friendsHandler(List<Friend> f) async {
    friends.clear();
    String _userId = UserController.get().user.value!.id;
    for (int i = 0; i < f.length; i++) {
      if (_userId != f[i].initiator.id) {
        friends.add(f[i].initiator);
      } else {
        friends.add(f[i].responder);
      }
    }
    // TODO: Update the specific widget id
    update(["SocialScreen"]);
  }

  /// Handler to filter requests
  _requestHandler(List<Friend> f) async {
    requests.clear();
    String _userId = UserController.get().user.value!.id;
    for (int i = 0; i < f.length; i++) {
      if (_userId == f[i].responder.id) {
        requests.add(f[i]);
      }
    }
    update(["SocialScreen"]);
  }

  /// Perform santization and search of users
  void searchText(String text) async {
    print("Search Users: ${text.trim()}");
    foundUsers = await socialRepo.findUsers(text.trim());
    print("Number of users found: ${foundUsers.length}");
    if (foundUsers.length > 0) {
      update(["SocialScreen"]);
    } else {
      Fluttertoast.showToast(
        msg: "No users found",
        backgroundColor: darkGrey,
        timeInSecForIosWeb: 2,
        gravity: ToastGravity.TOP,
        textColor: lightGrey,
      );
    }
  }

  /// Send request to user
  Future<void> sendRequest(String id) async {
    await socialRepo.sendRequest(id);
    await customPopUp("Request Sent!", successIcon(Get.theme.primaryColor));
  }

  /// Handle request match
  Future<void> handleResponse(
    String userId,
    String documentId,
    bool respond,
  ) async {
    print("Userid: ${userId}, DocumentId:${documentId}");
    await socialRepo.respondRequest(
      userId,
      documentId,
      respond,
    );
    update(["SocialScreen"]);
  }

  /// Clear search results and search text
  void clearText() {
    searchTextController?.clear();
    foundUsers.clear();

    /// Update screen
    update(["SocialScreen"]);
  }

  /// Fetch invitations
  Future<void> fetchInvitations() async {
    _workoutInvites = await socialRepo.getWorkoutInvites();
    update(["InvitationScreen"]);
  }

  // * Getters
  int get foundUsersLength => foundUsers.length;
  int get friendsLength => friends.length;
  int get requestsLength => requests.length;
  int get workoutInviteLength => _workoutInvites.length;

  List<WorkoutInvite> get getWorkoutInvitation => _workoutInvites;
}
