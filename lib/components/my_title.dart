import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final Icon titleIcon;
  final String title;

  const MyTitle({super.key, required this.title, required this.titleIcon});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      titleIcon,
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
