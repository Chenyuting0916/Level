import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
import 'package:localization/localization.dart';

class MyDialogWithTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final Function()? onYesPressed;
  final Function()? onNoPressed;

  const MyDialogWithTextField(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      required this.onYesPressed,
      required this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      content: TextField(
        decoration: InputDecoration(
          hintText: hintText
        ),
        controller: controller,
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
