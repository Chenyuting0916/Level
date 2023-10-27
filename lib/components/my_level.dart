import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:level/models/level.dart';

class MyLevel extends StatelessWidget {
  final int level;
  final int exp;
  const MyLevel({super.key, required this.level, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Lv. $level"),
          Text("Exp. $exp / ${Level(level: level, currentExp: exp).maxExp}"),
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      FAProgressBar(
        size: 12,
        progressColor: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentValue: exp.toDouble(),
        animatedDuration: const Duration(milliseconds: 600),
        maxValue: Level(level: level, currentExp: exp).maxExp.toDouble(),
      )
    ]);
  }
}
