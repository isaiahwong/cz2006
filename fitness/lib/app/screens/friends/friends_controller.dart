import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'friends_delegate.dart';

class FriendsController extends GetxController {
  late final SocialRepo socialRepo;
  late FriendsDelegate delegateController;

  List<Friend> filteredFriends = [];

  List<Friend> friends = [];

  factory FriendsController.to() {
    return Get.find();
  }

  FriendsController({
    SocialRepo? socialRepo,
    required this.delegateController,
    List<Friend>? selected,
  }) {
    this.socialRepo = socialRepo == null ? Get.find() : socialRepo;
  }

  @override
  void onInit() async {
    super.onInit();
    friends = await socialRepo.getFriends();
    friends = List.from(friends)
      ..map((e) =>
          delegateController.exists(e) ? delegateController.friends[e.id] : e);
    filteredFriends = List.from(friends);
    update();
  }

  bool isSelected(Friend ex) {
    return delegateController.exists(ex);
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
    if (isSelected(ex)) return delegateController.friends[ex.id];
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
