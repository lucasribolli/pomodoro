import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/screens/timer/components/Stopwatch.dart';
import 'package:pomodoro/screens/timer/components/TimeIn.dart';
import 'package:pomodoro/screens/utils/UIConstants.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PomodoroStore store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stopwatch(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 6.h,
              ),
              child: Observer(
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TimeIn(
                        title: Constants.WORK, 
                        value: store.workMinutes,
                        onIncrement: store.started && store.isWorking() 
                          ? null
                          : store.incrementWorkTime,
                        onDecrement: store.started && store.isWorking() 
                          ? null
                          : store.decrementWorkTime,
                      ),
                      TimeIn(
                        title: Constants.BREAK, 
                        value: store.breakMinutes,
                        onIncrement: store.started && store.isInBreak()
                          ? null
                          : store.incrementBreakTime,
                        onDecrement: store.started && store.isInBreak()
                          ? null
                          : store.decrementBreakTime,
                      )
                    ],
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}