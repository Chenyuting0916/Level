import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_hint.dart';
import 'package:level/components/my_title.dart';
import 'package:level/components/quest_tile.dart';
import 'package:level/models/daily_quests.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:localization/localization.dart';

class DailyQuestPage extends StatefulWidget {
  const DailyQuestPage({super.key});

  @override
  State<DailyQuestPage> createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  bool taskCompleted = false;
  void checkBoxTapped(bool? value, int index) {
    DailyQuestService().completeTask(index, value);
    setState(() {
      taskCompleted = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DailyQuests?>(
        future: DailyQuestService().getDailyQuest(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final dailyQuests = snapshot.data!;

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Column(children: [
                  MyTitle(
                      title: "DailyQuest".i18n(),
                      titleIcon: const Icon(Icons.task)),
                  const MyDivider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dailyQuests.dailyQuests.length,
                      itemBuilder: (context, index) {
                        return QuestTile(
                          questName:
                              dailyQuests.dailyQuests[index].dailyQuestName,
                          isCompleted:
                              dailyQuests.dailyQuests[index].isCompleted,
                          onChanged: (value) => checkBoxTapped(value, index),
                        );
                      },
                    ),
                  ),
                ]),
              ),
              floatingActionButton:
                  MyHint(hintMessage: "DailyQuestHint".i18n()),
            );
          } else {
            return Center(child: Text("NoDataFound".i18n()));
          }
        });
  }
}
