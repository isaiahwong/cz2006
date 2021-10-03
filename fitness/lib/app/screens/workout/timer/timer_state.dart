abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerRunPause extends TimerState {}

class TimerRunInProgress extends TimerState {}

class TimerRunComplete extends TimerState {}

class TimerRunCanceled extends TimerState {}
