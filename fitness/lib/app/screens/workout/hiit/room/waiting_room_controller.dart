import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/friends/friends_controller.dart';
import 'package:fitness/app/screens/friends/friends_delegate.dart';
import 'package:fitness/app/screens/friends/friends_list_screen.dart';
import 'package:fitness/app/screens/workout/hiit/active/active_hiit_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

enum WaitingRoomType {
  INVITEE,
  HOST,
}

class WaitingRoomController extends GetxController with FriendsDelegate {
  late HIIT hiit;
  final WorkoutRepo workoutRepo;
  final SlidingPanelController panelController;

  List<User> users = [];
  ResponseStream<WaitingRoomResponse>? hostRoomStream;
  ResponseStream<WaitingRoomResponse>? joinRoomStream;
  late final WaitingRoomType waitingRoomType;

  WaitingRoomController({required this.panelController})
      : this.workoutRepo = WorkoutRepo.get();

  @override
  Map<String, Friend> pendingFriends = {};

  @override
  void onInit() {
    super.onInit();
    print(Get.arguments);
    waitingRoomType = Get.arguments[0];
    hiit = Get.arguments[1];

    switch (waitingRoomType) {
      case WaitingRoomType.HOST:
        hostRoomStream = workoutRepo.createWaitingRoom(hiit);
        hostRoomStream?.listen(onHostRoomStream);
        break;
      case WaitingRoomType.INVITEE:
        joinRoomStream = workoutRepo.joinWaitingRoom(hiit);
        joinRoomStream?.listen(onJoinRoomStream);
        break;
    }
  }

  @override
  void onClose() {
    hostRoomStream?.cancel();
    joinRoomStream?.cancel();
    super.onClose();
  }

  @override
  bool exists(Friend ex) {
    return pendingFriends[ex.friend.id] != null;
  }

  @override
  bool notExists(Friend ex) {
    return pendingFriends[ex.friend.id] == null;
  }

  @override
  void onFriendsChanged(Friend ex) {
    if (notExists(ex)) return;
    pendingFriends[ex.friend.id] = ex.copyWith();
    update();
  }

  @override
  void onFriendsRemoved(Friend ex) {
    if (notExists(ex)) return;
    pendingFriends.remove(ex.friend.id);
    update();
  }

  @override
  void onFriendsSelected(Friend ex) async {
    pendingFriends[ex.friend.id] = ex;
    await workoutRepo.notifyInvite(ex.friend, hiit);
    update();
  }

  @override
  void onFriendsSelectionDone() {
    panelController.close();
    update();
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

  void onStartHIIT() async {
    if (waitingRoomType == WaitingRoomType.HOST)
      await workoutRepo.startWaitingRoom(hiit);
    Get.toNamed(RoutePaths.HIIT_ACTIVE, arguments: [
      ActiveHIITType.DUO,
      hiit.copyWith(),
    ]);
  }

  void onJoinRoomStream(WaitingRoomResponse response) {
    List<User> users = [
      User(
        id: response.host.id,
        email: response.host.email,
        name: response.host.name,
      )
    ];

    // If workout start
    if (response.start) {
      onStartHIIT();
      return;
    }

    for (WorkoutUser user in response.users)
      users.add(User(id: user.id, email: user.email, name: user.name));
    this.users = users;
    update();
  }

  void onHostRoomStream(WaitingRoomResponse response) {
    List<User> users = [];
    for (WorkoutUser user in response.users) {
      // Remove pending requests
      if (pendingFriends.containsKey(user.id)) pendingFriends.remove(user.id);
      users.add(User(id: user.id, email: user.email, name: user.name));
    }
    this.users = users;
    update();
  }
}
