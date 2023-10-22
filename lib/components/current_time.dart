import 'dart:async';

import 'package:flutter/material.dart';

class CurrentTime extends StatefulWidget {
  const CurrentTime({super.key});

  @override
  State<CurrentTime> createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeOfDay.minute != TimeOfDay.now().minute) {
        if (!mounted) return;
        setState(() {
          _timeOfDay = TimeOfDay.now();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${_timeOfDay.hour}:${getMinutes()}",
            style: const TextStyle(fontSize: 80)),
        const SizedBox(width: 5),
        RotatedBox(quarterTurns: 3, child: Text(period)),
      ],
    );
  }

  String getMinutes() => _timeOfDay.minute >= 10
      ? "${_timeOfDay.minute}"
      : "0${_timeOfDay.minute}";
}
