import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
import 'package:localization/localization.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final Function()? onYesPressed;
  final Function()? onNoPressed;

  const MyDialog(
      {super.key,
      required this.title,
      required this.onYesPressed,
      required this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      actions: [
        MyButton(
            buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
            buttonChild: Text("Yes".i18n()),
            onPressed: onYesPressed),
        MyButton(
            buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
            buttonChild: Text("No".i18n()),
            onPressed: onNoPressed),
      ],
    );
  }
}
