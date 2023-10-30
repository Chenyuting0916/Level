import 'package:flutter/material.dart';

class MyHint extends StatelessWidget {
  final String hintMessage;
  const MyHint({super.key, required this.hintMessage});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    hintMessage,
                    style: const TextStyle(fontSize: 18),
                  ),
                ));
      },
      child: Icon(
        Icons.lightbulb,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}