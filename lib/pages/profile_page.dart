import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_headshot_username.dart';
import 'package:level/components/my_level.dart';
import 'package:level/components/my_title.dart';
import 'package:localization/localization.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: ListView(
          children: [
            MyTitle(
                title: "Profile".i18n(), titleIcon: const Icon(Icons.person)),
            const MyDevider(),
            const MyHeadshotAndUsername(
              imageUrl: 'lib/assets/v10.png',
              username: "user.username",
            ),
            const MyLevel(level: 6, exp: 3),
          ],
        ),
      ),
    );
  }
}