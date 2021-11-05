import 'dart:async';

import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/friends/friends_controller.dart';
import 'package:fitness/app/screens/friends/friends_delegate.dart';
import 'package:fitness/app/screens/friends/friends_list_screen.dart';
import 'package:fitness/app/screens/workout/hiit/active/active_hiit_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/cycling_repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:get/get.dart';
import 'package:hiit_api/hiit.dart';
import 'package:grpc/grpc.dart';

enum WaitingRoomType {
  INVITEE,
  HOST,
}

class WaitingRoomController extends GetxController with FriendsDelegate {
  late Workout workout;
  final WorkoutRepo workoutRepo;
  final CyclingRepo cyclingRepo;
  final SlidingPanelController panelController;

  List<UserSnippet> users = [];
  ResponseStream<WaitingRoomResponse>? hostRoomStream;
  ResponseStream<WaitingRoomResponse>? joinRoomStream;

  StreamSubscription? hostSub;
  StreamSubscription? joinRoomSub;
  late final WaitingRoomType waitingRoomType;

  bool _isPublic = false;

  WaitingRoomController({required this.panelController})
      : this.workoutRepo = WorkoutRepo.get(),
        this.cyclingRepo = CyclingRepo.get();

  @override
  Map<String, Friend> pendingFriends = {};

  @override
  void onInit() {
    super.onInit();
    waitingRoomType = Get.arguments[0];
    workout = Get.arguments[1];

    switch (waitingRoomType) {
      case WaitingRoomType.HOST:
        hostRoomStream = workoutRepo.createWaitingRoom(workout);
        //cyclingRepo.createWaitingRoom(cycling);
        hostSub = hostRoomStream?.listen(onHostRoomStream);
        break;
      case WaitingRoomType.INVITEE:
        joinRoomStream = workoutRepo.joinWaitingRoom(workout);
        //cyclingRepo.joinWaitingRoom(cycling);
        joinRoomSub = joinRoomStream?.listen(onJoinRoomStream);
        break;
    }
  }

  void createWaitingRoom() {
    switch (waitingRoomType) {
      case WaitingRoomType.HOST:
        hostRoomStream = workoutRepo.createWaitingRoom(workout);
        //cyclingRepo.createWaitingRoom(cycling);
        hostSub = hostRoomStream?.listen(onHostRoomStream);
        break;
      case WaitingRoomType.INVITEE:
        joinRoomStream = workoutRepo.joinWaitingRoom(workout);
        //cyclingRepo.joinWaitingRoom(cycling);
        joinRoomSub = joinRoomStream?.listen(onJoinRoomStream);
        break;
    }
  }

  @override
  void onClose() {
    hostRoomStream?.cancel();
    hostSub?.cancel();
    joinRoomStream?.cancel();
    joinRoomSub?.cancel();
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
    await workoutRepo.notifyInvite(ex.friend, workout);
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

  void onStartPressed() async {
    if (workout is HIIT)
      onStartHIIT();
    else
      onStartCycling();
  }

  Future<void> onStartHIIT() async {
    await _publicFlag();
    if (users.length < 1) return;
    Get.offAndToNamed(RoutePaths.HIIT_ACTIVE, arguments: [
      ActiveHIITType.DUO,
      workout.copyWith(participants: users),
    ]);
  }

  void onStartCycling() {
    Get.offAndToNamed(RoutePaths.CYCLING_ACTIVE, arguments: [
      workout.copyWith(),
    ]);
  }

  void onJoinRoomStream(WaitingRoomResponse response) {
    // include host
    List<UserSnippet> users = [
      UserSnippet(response.host.id, response.host.name, "")
    ];

    // If workout start
    if (response.start) {
      if (workout is HIIT)
        onStartHIIT();
      else
        onStartCycling();
      return;
    }

    for (WorkoutUser user in response.users) {
      // Exclude currentUser
      if (user.id == UserController.get().user.value!.id) continue;
      users.add(UserSnippet(user.id, user.name, ""));
    }
    this.users = users;
    update();
  }

  /// Toggle isPublic switch
  void togglePublicSwitch(bool result) {
    _isPublic = result;
    update();
  }

  Future<void> _publicFlag() async {
    String? workoutId;
    if (!workout.isBlank!) {
      workoutId = workout.id;
    } else {
      workoutId = workout.id;
    }
    print("Setting ${workoutId} to ${_isPublic}");
    await SocialRepo.to.toggleWorkoutPublic(
      _isPublic,
      workoutId,
    );
  }

  void onHostRoomStream(WaitingRoomResponse response) {
    //  Include host
    List<UserSnippet> users = [];
    for (WorkoutUser user in response.users) {
      // Remove pending requests
      if (pendingFriends.containsKey(user.id)) pendingFriends.remove(user.id);
      users.add(UserSnippet(user.id, user.name, ""));
    }
    this.users = users;
    update();
  }

  bool get isPublic => _isPublic;
}
