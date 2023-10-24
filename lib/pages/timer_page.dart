import 'package:flutter/material.dart';
import 'package:level/components/animated_button.dart';
import 'package:level/components/current_time.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(80.0),
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          CurrentTime(),
          AnimatedButton(),
        ]),
      ),
    );
  }
}
