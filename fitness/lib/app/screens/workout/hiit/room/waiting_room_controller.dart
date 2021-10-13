import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/screens/friends/friends_controller.dart';
import 'package:fitness/app/screens/friends/friends_delegate.dart';
import 'package:fitness/app/screens/friends/friends_list_screen.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

class WaitingRoomController extends GetxController with FriendsDelegate {
  late HIIT hiit;
  final WorkoutRepo workoutRepo;
  final SlidingPanelController panelController;

  List<User> users = [];
  late final ResponseStream<WaitingRoomResponse> res;

  WaitingRoomController({required this.panelController})
      : this.workoutRepo = WorkoutRepo.get();

  @override
  Map<String, Friend> friends = {};

  @override
  void onInit() {
    super.onInit();
    hiit = Get.arguments;

    res = workoutRepo.createWaitingRoom(hiit);
    res.listen(onWaitingRoomStream);
  }

  @override
  void onClose() {
    res.cancel();
    super.onClose();
  }

  void onViewFriends() {
    panelController.open(
      panel: FriendsListScreen.component(
        exerciseController: FriendsController(
          delegateController: this,
        ),
      ),
    );
  }

  void onWaitingRoomStream(WaitingRoomResponse response) {
    List<User> users = [];
    for (HIITUser user in response.users)
      users.add(User(id: user.id, email: user.email, name: user.name));
    this.users = users;
    update();
  }

  @override
  bool exists(Friend ex) {
    return friends[ex.id] != null;
  }

  @override
  bool notExists(Friend ex) {
    return friends[ex.id] == null;
  }

  @override
  void onFriendsChanged(Friend ex) {
    if (notExists(ex)) return;
    friends[ex.id] = ex.copyWith();
    update();
  }

  @override
  void onFriendsRemoved(Friend ex) {
    if (notExists(ex)) return;
    friends.remove(ex.id);
    update();
  }

  @override
  void onFriendsSelected(Friend ex) async {
    friends[ex.id] = ex;
    await workoutRepo.notifyInvite(ex.friend, hiit);
    update();
  }

  @override
  void onFriendsSelectionDone() {
    panelController.close();
    update();
  }
}
