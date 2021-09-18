import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TimeIn extends StatelessWidget {
  final String title;
  final int value;
  final void Function()? onIncrement;
  final void Function()? onDecrement;

  const TimeIn({
    required this.title,
    required this.value,
    this.onIncrement,
    this.onDecrement
  });

  @override
  Widget build(BuildContext context) {
    final PomodoroStore pomodoroStore = Provider.of<PomodoroStore>(context);

    Color _getBackgroundButtonColor() {
      return pomodoroStore.isWorking()
        ? Colors.red
        : Colors.green;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          this.title,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        Observer(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ArrowButton(
                  Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  onDecrement,
                  _getBackgroundButtonColor()
                ),
                Text(
                '${this.value} min',
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                ArrowButton(
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                  onIncrement,
                  _getBackgroundButtonColor()
                ),
              ],
            );
          }
        ),
      ],
    );
  }
}

class ArrowButton extends StatelessWidget {
  final Icon buttonIcon;
  final Color backgroundColor;
  final void Function()? onPressed;

  const ArrowButton(this.buttonIcon, this.onPressed, this.backgroundColor);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: buttonIcon,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
        primary: backgroundColor,
      ),
    );
  }
}