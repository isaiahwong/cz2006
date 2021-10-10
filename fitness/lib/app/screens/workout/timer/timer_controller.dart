import 'dart:async';
import 'package:fitness/app/screens/workout/timer/timer.dart';
import 'package:fitness/common/ticker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get(String tag) => Get.find(tag: tag);

  VoidCallback? _onTimerDone;
  Ticker _ticker = Ticker();

  TimerState state = TimerInitial();
  DateTime start = DateTime.now();
  Duration duration = Duration(seconds: 0);
  int tick = 0;

  StreamSubscription<int>? _tickerSubscription;

  set onTimerDone(VoidCallback callback) {
    if (_onTimerDone != null) {
      print("onTimerDone has been set prior. Reinstantiate to reset callback.");
      return;
    }
    _onTimerDone = callback;
  }

  Duration get current {
    final d = duration - DateTime.now().difference(start);
    return d.isNegative ? Duration(seconds: 0) : d;
  }

  int get seconds => current.inSeconds - (current.inMinutes * 60);

  @override
  void onClose() {
    _tickerSubscription?.cancel();
    super.onClose();
  }

  void _onTimerTicked() {
    tick = current.inSeconds;
    if (current.inSeconds > 0) {
      state = TimerInProgress();
    } else {
      state = TimerComplete();
      _tickerSubscription?.cancel();
      if (_onTimerDone != null) this._onTimerDone!();
    }
    update();
  }

  void onTimerStart(Duration duration) {
    state = TimerInProgress();
    start = DateTime.now();
    this.duration = duration;
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: duration).listen((duration) => _onTimerTicked());
    update();
  }

  void onTimerPause() {
    if (!(state is TimerInProgress)) return;
    _tickerSubscription?.pause();
    state = TimerPause();
    update();
  }

  void onTimerResume() {
    if (!(state is TimerPause)) return;
    _tickerSubscription?.resume();
    state = TimerInProgress();
    update();
  }

  void onTimerCancel() {
    _tickerSubscription?.cancel();
    state = TimerCanceled();
    update();
  }

  void onTimerSet(Duration duration) {
    state = TimerPause();
    start = DateTime.now();
    this.duration = duration;
    update();
  }
}
