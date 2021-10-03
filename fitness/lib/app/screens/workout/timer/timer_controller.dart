import 'dart:async';
import 'package:fitness/app/screens/workout/timer/timer.dart';
import 'package:fitness/common/ticker.dart';
import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get(String tag) => Get.find(tag: tag);

  Ticker _ticker = Ticker();

  TimerState state = TimerInitial();
  DateTime start = DateTime.now();
  Duration duration = Duration(seconds: 0);
  int tick = 0;

  StreamSubscription<int>? _tickerSubscription;

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
      state = TimerRunInProgress();
    } else {
      state = TimerRunComplete();
      _tickerSubscription?.cancel();
    }
  }

  void onTimerStart(Duration duration) {
    state = TimerRunInProgress();
    start = DateTime.now();
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: duration).listen((duration) => _onTimerTicked());
    update();
  }

  void onTimerPause() {
    if (!(state is TimerRunInProgress)) return;
    _tickerSubscription?.pause();
    state = TimerRunPause();
    update();
  }

  void onTimerResume() {
    if (!(state is TimerRunPause)) return;
    _tickerSubscription?.resume();
    state = TimerRunInProgress();
    update();
  }

  void onTimerCancel() {
    _tickerSubscription?.cancel();
    state = TimerRunCanceled();
  }

  void onTimerSet(Duration duration) {
    state = TimerRunPause();
    start = DateTime.now();
    duration = duration;
    update();
  }
}
