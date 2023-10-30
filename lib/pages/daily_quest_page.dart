import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_hint.dart';
import 'package:level/components/my_title.dart';
import 'package:localization/localization.dart';

class DailyQuestPage extends StatelessWidget {
  const DailyQuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: ListView(children: [
          MyTitle(
              title: "DailyQuest".i18n(), titleIcon: const Icon(Icons.settings)),
          const MyDivider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: const Text("asd"),
            ),
          ),
        ]),
      ),
      floatingActionButton: MyHint(hintMessage: "DailyQuestHint".i18n()),
    );
  }
}
