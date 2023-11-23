import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:level/components/monthy_summary.dart';
import 'package:level/components/my_dialog.dart';
import 'package:level/components/my_dialog_with_textfield.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_hint.dart';
import 'package:level/components/my_titile_dropdown.dart';
import 'package:level/components/quest_tile.dart';
import 'package:level/models/title_dropdown.dart';
import 'package:level/models/todolist.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/pages/plan_page.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:level/services/todolist_service.dart';
import 'package:localization/localization.dart';

class DailyQuestPage extends StatefulWidget {
  const DailyQuestPage({super.key});

  @override
  State<DailyQuestPage> createState() => _DailyQuestPageState();
}

class _DailyQuestPageState extends State<DailyQuestPage> {
  final textController = TextEditingController();
  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TodoList?>(
        future: TodoListService().getTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final dailyQuests = snapshot.data!.dailyQuests!;

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 45),
                child: Column(children: [
                  MyTitleWithDropDown(
                    currentTitleValue: "DailyQuest",
                    titleIcon: const Icon(Icons.task),
                    titleDropdown: [
                      TitleDropDown(
                          value: "DailyQuest",
                          name: "DailyQuest".i18n(),
                          jumpPage: const HomePage(selectedIndex: 2)),
                      TitleDropDown(
                          value: "FuturePlan",
                          name: "FuturePlan".i18n(),
                          jumpPage: const PlanPage()),
                    ],
                    todoList: snapshot.data!,
                  ),
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
                          editOnPressed: (context) => editQuestDialog(index,
                              dailyQuests.dailyQuests[index].dailyQuestName),
                          deleteOnPressed: (context) =>
                              deleteQuestDialog(index),
                          questOnTapped: () {
                            editQuestDialog(index,
                                dailyQuests.dailyQuests[index].dailyQuestName);
                          },
                        );
                      },
                    ),
                  ),
                ]),
              ),
              floatingActionButton: AnimatedFloatingActionButton(
                fabButtons: [
                  FloatingActionButton(
                    heroTag: "Plan",
                    onPressed: goToPlanPage,
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  MyHint(hintMessage: 'DailyQuestHint'.i18n()),
                  FloatingActionButton(
                    heroTag: "NewQuestDialog",
                    onPressed: addNewQuestDialog,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  )
                ],
                key: key,
                animatedIconData: AnimatedIcons.menu_close,
                colorStartAnimation: Theme.of(context).colorScheme.secondary,
                colorEndAnimation: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else {
            return Center(child: Text("NoDataFound".i18n()));
          }
        });
  }

  Future<void> checkBoxTapped(bool? value, int index) async {
    await DailyQuestService().completeTask(index, value);
    setState(() {});
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
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              onNoPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              });
        });
  }

  editQuestDialog(int index, String dailyQuestName) async {
    showDialog(
        context: context,
        builder: (context) {
          textController.text = dailyQuestName;
          return MyDialogWithTextField(
              controller: textController,
              title: "EnterYourDailyQuest".i18n(),
              hintText: "EnterYourDailyQuest".i18n(),
              onYesPressed: () async {
                await DailyQuestService()
                    .editDailyQuest(index, textController.text);
                textController.clear();
                setState(() {
                  Navigator.of(context).pop();
                });
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
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              onNoPressed: () {
                Navigator.of(context).pop();
              });
        });
  }

  void goToPlanPage() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, _) {
        return const PlanPage();
      },
    ));
  }
}
