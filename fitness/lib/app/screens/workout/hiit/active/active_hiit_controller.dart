import 'dart:async';

import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/workout/hiit/active/pose/pose_controller.dart';
import 'package:fitness/app/screens/workout/timer/timer.dart';
import 'package:fitness/repo/repo.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:hiit_api/hiit.dart';
import 'package:hiit_api/hiit.pbenum.dart';
import 'active_hiit_state.dart';

enum ActiveHIITType {
  DUO,
  SINGLE,
}

class ActiveHIITController extends GetxController {
  final SlidingPanelController panelController;
  final FullScreenPanelController fullscreenController;
  final TimerController timerController;
  final PoseController poseController;
  final WorkoutRepo workoutRepo;
  final PageController pageController = PageController(initialPage: 0);

  late final ActiveHIITType activeHIITType;
  late final bool isHost;

  ResponseStream<HIITActivity>? hostHIITStream;
  ResponseStream<HIITActivity>? joinHIITStream;

  StreamSubscription? hostSub;
  StreamSubscription? joinRoomSub;

  int currentReps = 0;
  int page = 0;

  late HIIT hiit;

  List<UserSnippet> usersCompleted = [];
  UserSnippet? winner;
  RoutineInterval? currentInterval;
  Routine? currentRoutine;

  ActiveWorkoutState state = ActiveWorkoutWorking();
  late final ResponseStream<Data> res;

  ActiveHIITController({
    SlidingPanelController? panelController,
    FullScreenPanelController? fullscreenController,
    TimerController? timerController,
  })  : this.panelController = panelController == null
            ? SlidingPanelController.get(RoutePaths.HIIT_DETAILS)
            : panelController,
        this.fullscreenController = fullscreenController == null
            ? FullScreenPanelController.get(RoutePaths.HIIT_ACTIVE)
            : fullscreenController,
        this.timerController = TimerController.get(RoutePaths.HIIT_ACTIVE),
        this.poseController = PoseController.get(),
        this.workoutRepo = WorkoutRepo.get() {
    timerController!.onTimerDone = onRestDone;
    res = workoutRepo.startHIITStream();
    res.listen(onHIITStream);
  }

  bool get poseStarted => poseController.started;

  @override
  void onInit() {
    super.onInit();
    activeHIITType = Get.arguments[0];
    hiit = Get.arguments[1];
    fullscreenController.addFullScreenListener(onFullScreenPanelChange);
    _onDUO();
  }

  @override
  void onClose() {
    super.onClose();
    poseController.stopCall();
    hostHIITStream?.cancel();
    joinHIITStream?.cancel();
    hostSub?.cancel();
    joinRoomSub?.cancel();
    res.cancel();
  }

  void _onDUO() async {
    if (activeHIITType != ActiveHIITType.DUO) return;
    // Create hiit room if host
    final user = UserController.get().user.value!;
    if (user.id == hiit.host) {
      isHost = true;
      // Create HIIT session
      hostHIITStream = workoutRepo.createDuoHIIT(hiit);
      hostSub = hostHIITStream!.listen(onHIITActivity);
    } else {
      // join room if not
      isHost = false;
      joinHIITStream = workoutRepo.joinDuoHIIT(hiit);
      joinRoomSub = joinHIITStream!.listen(onHIITActivity);
    }
  }

  // /// Host handler
  // void onHIITHostActivity(HIITActivity activity) {
  //   switch (activity.type) {
  //     case HIITActivity_Type.INTERVAL_COMPLETE:
  //       onParticipantIntervalCompleted(activity);
  //       break;
  //   }
  // }

  /// Users who join room handler
  void onHIITActivity(HIITActivity activity) {
    switch (activity.type) {
      case HIITActivity_Type.ROUTINE_CHANGE:
        onDUORoutineChange(activity);
        break;
      case HIITActivity_Type.INTERVAL_COMPLETE:
        onParticipantIntervalCompleted(activity);
        break;
      case HIITActivity_Type.ROUTINE_COMPLETE:
        onParticipantRoutineComplete(activity);
        break;
    }
  }

  // The function changes routines automatically
  void onDUORoutineChange(HIITActivity activity) {
    // ignore if its invoked by current user
    // if (activity.user.id == UserController.get().user.value!.id) return;
    state = ActiveWorkoutWorking();
    final routine = hiit.getRoutine(activity.routine.id);
    if (routine == null) return;
    final interval = routine.getInterval(activity.routine.interval.id);
    if (interval == null) return;
    currentInterval = interval;
    currentRoutine = routine;
    startPose();
    fullscreenController.open();
    update();
  }

  /// pose net stream
  void onHIITStream(Data data) {
    currentReps = data.count;
    update();

    if (currentReps != currentInterval!.defaultReps) return;
    // If workout completed
    poseController.stopCall();

    switch (activeHIITType) {
      case ActiveHIITType.DUO:
        onDuoIntervalCompleted();
        break;
      case ActiveHIITType.SINGLE:
        onIntervalCompleted();
        break;
    }
  }

  void onFullScreenPanelChange() {
    if (fullscreenController.status is FullScreenStatusOpened) return;
    // poseController.stopCall();
  }

  void stopPose() async {
    if (poseController.started) await poseController.stopCall();
    update();
  }

  void startPose() async {
    if (currentRoutine == null ||
        poseController.loading ||
        poseController.started) return;
    await poseController.makeCall(
      exercise: currentRoutine!.exercise,
      user: UserController.get().user.value!,
      interval: currentInterval!,
    );
    update();
  }

  void onOpenFullPanel() {
    if (currentInterval == null) return;
    fullscreenController.open();
  }

  void onHideFullPanel() {
    fullscreenController.hide();
  }

  void onSlidingPanelClose() {
    panelController.close();
  }

  void onIntervalSelected(Routine routine, RoutineInterval interval) async {
    if (activeHIITType == ActiveHIITType.DUO) {
      if (!isHost) return;
      await workoutRepo.duoHIITSelectRoutine(routine, interval);
      return;
    }
    currentInterval = interval;
    currentRoutine = routine;
    fullscreenController.open();
    update();
  }

  /// defines the logic for duo interval completed
  void onDuoIntervalCompleted() async {
    if (currentInterval == null) return;
    // Update interval
    final interval = currentInterval!.copyWith(
      currentLog: currentInterval!.currentLog.copyWith(completed: true),
    );
    currentInterval = interval.copyWith();

    // Update current interval
    _updateWorkout(interval: interval);

    // Navigate to waiting room when not everyone has completed
    if (!allUsersCompleted()) {
      pageController.animateToPage(1,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    }

    // This has to be called last in the event onParticipantInteval gets called first
    await workoutRepo.duoHIITIntervalComplete(currentRoutine!, interval);
    update();
  }

  void onParticipantRoutineComplete(HIITActivity activity) {
    // This might be null grpc has no support for null safety yet
    winner = UserSnippet(activity.winner.id, activity.winner.name, "");
    state = ActiveWorkoutComplete();
    // We increment index to prepare for next set of duoPages
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    update();
  }

  void onParticipantIntervalCompleted(HIITActivity activity) {
    final user = activity.user;

    // Don't add current user
    if (user.id != UserController.get().user.value!.id)
      usersCompleted.add(UserSnippet(user.id, user.name, ""));

    // Check if all participants completed
    if (currentInterval!.currentLog.completed && allUsersCompleted()) {
      usersCompleted = [];
      if (currentRoutine!.isLastInterval(currentInterval!)) {
        // Only host notifies server
        if (isHost) workoutRepo.duoHIITRoutineComplete(currentRoutine!);

        return;
      }

      onRest();
    }
  }

  void onDouRoutineWinnerSelection(Routine nextRoutine) async {
    await workoutRepo.duoHIITSelectRoutine(
        nextRoutine, nextRoutine.getCurrentInterval()!);
  }

  bool allUsersCompleted() {
    return usersCompleted.length == hiit.participants.length;
  }

  void onIntervalCompleted() {
    if (activeHIITType == ActiveHIITType.DUO) return;
    if (currentInterval == null) return;

    final interval = currentInterval!.copyWith(
      currentLog: currentInterval!.currentLog.copyWith(completed: true),
    );

    // Update current interval
    _updateWorkout(interval: interval);

    // return complete
    if (hiit.isLastRoutine(interval)) {
      state = ActiveWorkoutComplete();
      return;
    }

    onRest();

    update();
  }

  void onRest() {
    switch (activeHIITType) {
      case ActiveHIITType.DUO:
        pageController.animateToPage(2,
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        break;
      case ActiveHIITType.SINGLE:
        pageController.animateToPage(1,
            duration: Duration(milliseconds: 400), curve: Curves.easeIn);
        break;
    }
    // update state
    state = ActiveWorkoutRest();
    // Start rest timer
    timerController
        .onTimerStart(Duration(seconds: currentInterval!.defaultRestDuration));
  }

  void onRestDone() {
    switch (activeHIITType) {
      case ActiveHIITType.SINGLE:
        _onNext();
        break;
      case ActiveHIITType.DUO:
        _onDuoNext();
        break;
    }
  }

  void onRoutineSkip() {
    if (activeHIITType == ActiveHIITType.DUO) return;
    // Cancel any pending timers
    timerController.onTimerCancel();
    _onNext();
  }

  void _onDuoNext() {
    RoutineInterval? nextInterval =
        currentRoutine!.nextInterval(current: currentInterval);
    // Attempt to get next routine if next interval is null
    // assume routine is set by winner
    if (nextInterval == null && currentRoutine == null) {
      nextInterval = currentRoutine!.getCurrentInterval();
      if (nextInterval == null) return;
    }
    currentInterval = nextInterval!.copyWith();

    startPose();

    fullscreenController.open();
    pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    state = ActiveWorkoutWorking();
    update();
  }

  ///  _mapNext would yield next routine from current exercise state
  /// It will map a routine if provided
  void _onNext({RoutineInterval? interval}) {
    RoutineInterval? _interval = interval ?? currentInterval;

    if (interval == null && currentRoutine == null) return;

    RoutineInterval? nextInterval =
        currentRoutine!.nextInterval(current: _interval);

    // Attempt to get next routine if next interval is null
    if (nextInterval == null) {
      final nextRoutine = hiit.nextRoutine(currentRoutine);
      // end fn call if both next routine and interval is null
      if (nextRoutine == null) return;

      nextInterval = nextRoutine.getCurrentInterval();
      if (nextInterval == null) return;

      currentRoutine = nextRoutine.copyWith();
    }

    currentInterval = nextInterval.copyWith();

    startPose();

    fullscreenController.open();
    pageController.animateToPage(0,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    state = ActiveWorkoutWorking();
    update();
  }

  void _updateWorkout({
    Routine? routine,
    RoutineInterval? interval,
  }) {
    if (routine == null && interval == null) return;

    // Update routine if provided
    if (interval != null) {
      routine = hiit.getRoutine(interval.routine);
      if (routine == null) return;
      routine = routine.updateInterval(interval);
    }

    hiit = hiit.updateRoutine(routine!);
    currentRoutine = routine;
    update();
  }

  void onHIITEnd() {
    Get.back();
  }
}
