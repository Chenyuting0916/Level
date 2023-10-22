import 'package:flutter/material.dart';
import 'package:level/components/animated_button.dart';
import 'package:level/components/current_time.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(80.0),
        child: Column(children: [
          SizedBox(height: 50,),
          CurrentTime(),
          AnimatedButton(),
        ]),
      ),
    );
  }
}
