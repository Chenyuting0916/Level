import 'dart:async';
import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_dialog.dart';
import 'package:level/models/user.dart';
import 'package:level/pages/focus_score_page.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/services/status_service.dart';
import 'package:localization/localization.dart';

class MyTimer extends StatefulWidget {
  final int categoryId;
  const MyTimer({super.key, required this.categoryId});

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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MyAppbar(
            appbarTitle: "",
            onPressed: () {
              openMissClickDialog();
            }),
        body: GestureDetector(
          onLongPress: () {
            openLongPressDialog();
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
        ),
      ),
    );
  }

  void openLongPressDialog() => showDialog(
      context: context,
      builder: (context) => MyDialog(
          title: "SureToStop".i18n(),
          onYesPressed: () async {
            User oldUser = await StatusService()
                .updateStatus(widget.categoryId, duration.inSeconds);
            if (!context.mounted) return;
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return FocusScorePage(
                    categoryId: widget.categoryId, oldUser: oldUser);
              },
            ));
          },
          onNoPressed: () {
            Navigator.of(context).pop();
          }));

  void openMissClickDialog() => showDialog(
      context: context,
      builder: (context) => MyDialog(
          title: "SureToStopWithoutExp".i18n(),
          onYesPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return const HomePage(
                  selectedIndex: 1,
                );
              },
            ));
          },
          onNoPressed: () {
            Navigator.of(context).pop();
          }));
}
