import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:localization/localization.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: ListView(
          children: [
            MyTitle(title: "Rank".i18n(), titleIcon: const Icon(Icons.bar_chart_outlined)),
            const MyDevider()
          ],
        ),
      ),
    );
  }
}