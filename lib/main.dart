import 'package:flutter/material.dart';
import 'package:pomodoro/screens/timer/pages/Pomodoro.dart';
import 'package:pomodoro/screens/utils/UIConstants.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            Provider<PomodoroStore>(
              create: (_) => PomodoroStore(),
            )
          ],
          child: MaterialApp(
            title: Constants.POMODORO,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Pomodoro(),
          ),
        );
      },
    );
  }
}