import 'dart:async';
import 'package:mobx/mobx.dart';
part 'pomodoro.store.g.dart';

// generate code with `flutter pub run build_runner watch`

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TimerType {
  WORK,
  BREAK
}

abstract class _PomodoroStore with Store {
  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  int workMinutes = 2;

  @observable
  int breakMinutes = 1;

  @observable
  bool started = false;

  @observable
  TimerType timerType = TimerType.WORK;

  Timer? timer;

  @action
  void start() {
    started = true;
    timer = _startTimer();
  }

  @action
  void stop() {
    started = false;
    timer?.cancel();
  }

  @action
  void restart() {
    stop();
    minutes = isWorking() ? workMinutes : breakMinutes;
    seconds = 0;
  }

  @action
  void incrementWorkTime() {
    workMinutes++;
    if(isWorking()) {
      restart();
    }
  }
  
  @action
  void decrementWorkTime() {
    if(workMinutes == 1) {
      return;
    }
    workMinutes--;
    if(isWorking()) {
      restart();
    }
  }
  
  @action
  void incrementBreakTime() {
    breakMinutes++;
    if(isInBreak()) {
      restart();
    }
  }
  
  @action
  void decrementBreakTime() {
    if(breakMinutes == 1) {
      return;
    }
    breakMinutes--;
    if(isInBreak()) {
      restart();
    }
  }

  bool isWorking() {
    return timerType == TimerType.WORK;
  }

  bool isInBreak() {
    return timerType == TimerType.BREAK;
  }

  void _swapTimerInterval() {
    if(isWorking()) {
      timerType = TimerType.BREAK;
      minutes = breakMinutes;
    } else {
      timerType = TimerType.WORK;
      minutes = workMinutes;
    }
    seconds = 0;
  }

  Timer _startTimer() {
    return Timer.periodic(Duration(seconds: 1), 
      (Timer timer) { 
        if(minutes == 0 && seconds == 0) {
          _swapTimerInterval();
        } else if (seconds == 0) {
          seconds = 59;
          minutes--;
        } else {
          seconds--;
        }
    });
  }
}

