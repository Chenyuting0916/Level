import 'dart:async';

import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
import 'package:level/pages/focus_score_page.dart';
import 'package:localization/localization.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSecond = 1;
    if (!mounted) return;
    setState(() {
      final seconds = duration.inSeconds + addSecond;

      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    String toTwoDigits(int i) => i.toString().padLeft(2, '0');
    final minutes = toTwoDigits(duration.inMinutes.remainder(60));
    final seconds = toTwoDigits(duration.inSeconds.remainder(60));
    final hours = toTwoDigits(duration.inHours.remainder(60));

    return GestureDetector(
      onLongPress: () {
        openDialog();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$hours:$minutes:$seconds",
                  style: const TextStyle(fontSize: 70)),
              const SizedBox(height: 4),
              Text("LongPressToStop".i18n(),
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  void openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("SureToStop".i18n(),
            style: TextStyle(fontSize: 18),),
            actions: [
              MyButton(
                  buttonText: "Yes".i18n(),
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, _) {
                        return const FocusScorePage();
                      },
                    ));
                  }),
              MyButton(
                  buttonText: "No".i18n(),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ));
}
