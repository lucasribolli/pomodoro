class TimerUtils {
  final int minutes;
  final int seconds;

  TimerUtils(this.minutes, this.seconds);

  String formatTimer() {
    String secondsFormatted = _convertToTwoDigits(seconds);
    String minutesFormatted = _convertToTwoDigits(minutes);

    StringBuffer buffer = StringBuffer();
    buffer.write(minutesFormatted);
    buffer.write(':');
    buffer.write(secondsFormatted);
    return buffer.toString();
  }

  String _convertToTwoDigits(int number) {
    return number.toString().padLeft(2, '0');
  }
}