import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SocialController extends GetxController {
  static SocialController to = Get.find();
  late SocialRepo socialRepo;

  List<User> friends = [];
  List<FriendRequest> requests = [];

  List<User> foundUsers = [];

  TextEditingController? searchTextController;

  @override
  void onInit() {
    socialRepo = Get.find<SocialRepo>();
    searchTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    /// Call repo
    requests = await socialRepo.getRequests();
    friends = await socialRepo.getFriends();
    super.onReady();
  }

  /// Perform santization and search of users
  void searchText(String text) async {
    print("Search Users: ${text.trim()}");
    foundUsers = await socialRepo.findUsers(text);
    print("Number of users found: ${foundUsers.length}");
    if (foundUsers.length > 0) {
      /// Update to user list screen
      update();
    } else {
      Get.snackbar(
        "Search results",
        "No users found",
        backgroundColor: Colors.white60,
        snackStyle: SnackStyle.GROUNDED,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Clear search results and search text
  void clearText() {
    searchTextController?.clear();
    foundUsers.clear();

    /// Update screen
    update();
  }
}
