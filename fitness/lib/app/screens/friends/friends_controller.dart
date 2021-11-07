import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'friends_delegate.dart';

class FriendsController extends GetxController {
  late final SocialRepo socialRepo;
  late FriendsDelegate delegateController;

  // Due to the misalignment in the data structures used in the app
  // This is a dirty workaround to filter invited friends for workout.
  List<UserSnippet> userSnippetAddToPending;

  List<Friend> filteredFriends = [];

  List<Friend> friends = [];

  bool showError = false;

  factory FriendsController.to() {
    return Get.find();
  }

  FriendsController({
    SocialRepo? socialRepo,
    this.userSnippetAddToPending = const [],
    required this.delegateController,
    List<Friend>? selected,
  }) {
    this.socialRepo = socialRepo == null ? Get.find() : socialRepo;
  }

  @override
  void onInit() async {
    super.onInit();
    friends = await socialRepo.getFriends();
    if (userSnippetAddToPending.isNotEmpty)
      friends.forEach((friend) {
        userSnippetAddToPending.forEach((us) {
          if (friend.id == us.id)
            delegateController.onFriendsSelectedWithParam(friend, false);
        });
      });

    friends = List.from(friends)
      ..map((e) => delegateController.friendExists(e)
          ? delegateController.pendingFriends[e.id]
          : e);
    filteredFriends = List.from(friends);
    update();
  }

  bool isSelected(Friend ex) {
    return delegateController.friendExists(ex);
  }

  void onFilter(String query) {
    /// Returns all items if query is empty
    if (query.isEmpty) {
      filteredFriends = List.from(friends);
      update();
      return;
    }
    filteredFriends = List<Friend>.from(friends)
        .where((e) =>
            e.responder.name.toLowerCase().contains(query.toLowerCase()) ||
            e.initiator.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    update();
  }

  Friend? onSelected(Friend ex) {
    if (isSelected(ex)) return delegateController.pendingFriends[ex.id];
    if (delegateController.friendsLimit ==
        delegateController.pendingFriends.length) {
      showError = true;
      Future.delayed(const Duration(milliseconds: 1000), () {
        showError = false;
        update();
      });
      update();
      return null;
    }
    delegateController.onFriendsSelected(ex);
    update();
    return ex;
  }

  void onRemove(Friend ex) {
    if (!isSelected(ex)) return;
    delegateController.onFriendsRemoved(ex);
    update();
  }
}
