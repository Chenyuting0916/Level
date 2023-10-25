import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget buttonChild;
  final void Function()? onPressed;
  final Color buttonBackgroundColor;

  const MyButton({super.key, required this.buttonChild, required this.onPressed, required this.buttonBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackgroundColor,
            foregroundColor: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            splashFactory: NoSplash.splashFactory),
        onPressed: onPressed,
        child: buttonChild);
  }
}
