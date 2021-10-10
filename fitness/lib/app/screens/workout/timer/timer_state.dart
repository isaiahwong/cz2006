abstract class TimerState {}

class TimerInitial extends TimerState {}

class TimerPause extends TimerState {}

class TimerInProgress extends TimerState {}

class TimerComplete extends TimerState {}

class TimerCanceled extends TimerState {}
