import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/screens/timer/components/StopwatchButton.dart';
import 'package:pomodoro/screens/utils/UIConstants.dart';
import 'package:pomodoro/screens/utils/Utils.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Stopwatch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PomodoroStore pomodoroStore = Provider.of<PomodoroStore>(context);

    String _getTimerText() {
      TimerUtils timer = TimerUtils(pomodoroStore.minutes, pomodoroStore.seconds);
      return timer.formatTimer();
    }

    String _getWhatToDoText() {
      return pomodoroStore.isWorking() 
        ? Constants.TIME_TO_WORK 
        : Constants.TIME_TO_TAKE_A_BREAK;
    }

    Color _getBackgroundColor() {
      return pomodoroStore.isWorking() 
        ? Colors.red 
        : Colors.green;
    }

    return Observer(
      builder: (_) {
        return Container(
          color: _getBackgroundColor(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _getWhatToDoText(),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                _getTimerText(),
                style: TextStyle(
                  fontSize: 60.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!pomodoroStore.started) 
                    Padding(
                      padding: EdgeInsets.all(1.5.h),
                      child: StopwatchButton(
                        icon: Icons.play_arrow,
                        text: Constants.START,
                        onPressed: pomodoroStore.start,
                      ),
                    ),
                  if(pomodoroStore.started)
                    Padding(
                      padding: EdgeInsets.all(1.5.h),
                      child: StopwatchButton(
                        icon: Icons.stop,
                        text: Constants.STOP,
                        onPressed: pomodoroStore.stop,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.all(1.5.h),
                    child: StopwatchButton(
                      icon: Icons.refresh,
                      text: Constants.RESTART,
                      onPressed: pomodoroStore.restart,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }
    );
  }

    
}