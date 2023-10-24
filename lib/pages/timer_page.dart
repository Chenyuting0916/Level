import 'package:flutter/material.dart';
import 'package:level/components/animated_button.dart';
import 'package:level/components/current_time.dart';
import 'package:level/components/timer_category.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  bool openCategory = false;

  void _goToCategoryPage(String param) {
    setState(() {
      openCategory = !openCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          const CurrentTime(),
          const AnimatedButton(),
          if (openCategory) TimerCategoryPage(),
        ]),
      ),
    );
  }
}
