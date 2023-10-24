import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  void Function()? onPressed;

  MyButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            splashFactory: NoSplash.splashFactory),
        onPressed: onPressed,
        child: Text(buttonText));
  }
}
