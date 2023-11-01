import 'package:flutter/material.dart';
import 'package:level/components/monthy_summary.dart';
import 'package:level/components/my_dialog.dart';
import 'package:level/components/my_dialog_with_textfield.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/components/quest_tile.dart';
import 'package:level/models/daily_quests.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:localization/localization.dart';

class DailyQuestPage extends StatefulWidget {
  const DailyQuestPage({super.key});

  @override
  State<DailyQuestPage> createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  final textController = TextEditingController();

  Future<void> checkBoxTapped(bool? value, int index) async {
    await DailyQuestService().completeTask(index, value);
    if (!mounted) return;
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, _) {
        return const HomePage(selectedIndex: 2);
      },
    ));
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
                  MonthlySummary(datasets: dailyQuests.datasets),
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
                          editOnPressed: (context) => editQuestDialog(index),
                          deleteOnPressed: (context) =>
                              deleteQuestDialog(index),
                          questOnTapped: () {
                            editQuestDialog(index);
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              floatingActionButton: Visibility(
                visible: dailyQuests.dailyQuests.length <= 3,
                child: FloatingActionButton(
                  onPressed: addNewQuestDialog,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text("NoDataFound".i18n()));
          }
        });
  }

  void addNewQuestDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialogWithTextField(
              controller: textController,
              title: "EnterYourDailyQuest".i18n(),
              hintText: "EnterYourDailyQuest".i18n(),
              onYesPressed: () async {
                await DailyQuestService().addNewDailyQuest(textController.text);
                textController.clear();
                if (!mounted) return;
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, _) {
                    return const HomePage(selectedIndex: 2);
                  },
                ));
              },
              onNoPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              });
        });
  }

  editQuestDialog(int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialogWithTextField(
              controller: textController,
              title: "EnterYourDailyQuest".i18n(),
              hintText: "EnterYourDailyQuest".i18n(),
              onYesPressed: () async {
                await DailyQuestService()
                    .editDailyQuest(index, textController.text);
                textController.clear();
                if (!mounted) return;
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, _) {
                    return const HomePage(selectedIndex: 2);
                  },
                ));
              },
              onNoPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              });
        });
  }

  deleteQuestDialog(int index) async {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog(
              title: "SureToDeleteQuest".i18n(),
              onYesPressed: () async {
                await DailyQuestService().deleteQuest(index);
                textController.clear();
                if (!mounted) return;
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, _) {
                    return const HomePage(selectedIndex: 2);
                  },
                ));
              },
              onNoPressed: () {
                Navigator.of(context).pop();
              });
        });
  }
}
