import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Widget buttonChild;
  final void Function()? onPressed;
  final Color buttonBackgroundColor;

  const MyIconButton(
      {super.key,
      required this.buttonChild,
      required this.onPressed,
      required this.buttonBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: buttonChild);
  }
}