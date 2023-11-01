import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:level/pages/timer_category_page.dart';
import 'package:localization/localization.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              elevation: 0,
              splashFactory: NoSplash.splashFactory),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return const TimerCategoryPage();
              },
            ));
          },
          child: AvatarGlow(
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
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
