import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({super.key});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        AvatarGlow(
          glowColor: Theme.of(context).colorScheme.tertiary,
          endRadius: 120.0,
          child: Material(
            elevation: 8.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 60.0,
              child: Text(
                "StartFocus".i18n(),
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.bold,
                fontSize: 15),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
