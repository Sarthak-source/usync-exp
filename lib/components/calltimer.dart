import 'package:flutter/cupertino.dart';
import 'package:flutter_module/ui/typography/text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';  // Import stop_watch_timer

class CallTimer extends StatefulWidget {
  const CallTimer({super.key});

  @override
  CallTimerState createState() => CallTimerState();
}

class CallTimerState extends State<CallTimer> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp
  ); // Create instance.

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();  // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: _stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data!;
        final displayTime =
        StopWatchTimer.getDisplayTime(value, hours: false, milliSecond: false, secondRightBreak: ":");
        return UsyncText(
          displayTime,
          type: UsyncTextType.title3Regular,
          padding: const EdgeInsets.only(bottom: 10),
        );
      },
    );
  }
}
