import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SocialController extends GetxController {
  late SocialRepo socialRepo;

  List<User> friends = [];
  List<FriendRequest> requests = [];

  @override
  void onInit() {
    socialRepo = Get.find<SocialRepo>();
    super.onInit();
  }

  @override
  void onReady() async {
    /// Call repo
    requests = await socialRepo.getRequests();
    friends = await socialRepo.getFriends();
    super.onReady();
  }
}
