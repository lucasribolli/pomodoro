import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StopwatchButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const StopwatchButton({ 
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 1.w,
            ),
            child: Icon(
              this.icon,
              size: 3.h,
            ),
          ),
          Text(
            text,
          )
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.symmetric(
          vertical: 1.8.h,
          horizontal: 4.w
        ),
        textStyle: TextStyle(
          fontSize: 13.sp,
        )
      ),
    );
  }
}