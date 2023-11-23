import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/models/todolist.dart';
import 'package:level/models/title_dropdown.dart';
import 'package:level/pages/plan_page.dart';
import 'package:localization/localization.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTitleWithDropDown extends StatelessWidget {
  final Icon titleIcon;
  final String currentTitleValue;
  final List<TitleDropDown> titleDropdown;
  final TodoList todoList;
  const MyTitleWithDropDown(
      {super.key,
      required this.currentTitleValue,
      required this.titleIcon,
      required this.titleDropdown,
      required this.todoList});

  @override
  Widget build(BuildContext context) {
    final inCompleteDaily = todoList.dailyQuests?.dailyQuests
        .where((element) => !element.isCompleted);
    final inCompletePlan = todoList.events?.where((element) =>
        !element.isCompleted && isSameDay(element.eventDate, DateTime.now()));
    final inCompleteDailyLength =
        inCompleteDaily == null ? 0 : inCompleteDaily.length;
    final inCompletePlanLength =
        inCompletePlan == null ? 0 : inCompletePlan.length;

    return Row(children: [
      titleIcon,
      const SizedBox(width: 8),
      DropdownButton<String>(
          value: currentTitleValue,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          items: [
            ...titleDropdown.map(
              (e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(
                    e.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary),
                  )),
            )
          ],
          onChanged: (value) {
            if (value == currentTitleValue) return;
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return titleDropdown
                    .where((element) => element.value == value)
                    .first
                    .jumpPage;
              },
            ));
          }),
      const Spacer(),
      InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("TodoList".i18n(),),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (inCompleteDailyLength + inCompletePlanLength == 0)
                          Text("Congratulation".i18n()),
                        if (inCompleteDailyLength > 0)
                          Text("InCompleteDaily".i18n()),
                        ...inCompleteDaily!.map((e) => Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(e.dailyQuestName))),
                        if (inCompleteDailyLength > 0) const MyDivider(),
                        if (inCompletePlanLength > 0)
                          Text(
                              "${DateTime.now().toString().substring(0, 10)}:"),
                        ...inCompletePlan!.map((e) => InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation, _) {
                                    return const PlanPage();
                                  },
                                ));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(e.eventName)),
                            )),
                      ],
                    ),
                  ));
        },
        child: (inCompleteDailyLength + inCompletePlanLength > 0)
            ? Badge(
                label: Text(
                    (inCompleteDailyLength + inCompletePlanLength).toString()),
                child: const Icon(Icons.notifications),
              )
            : const Icon(Icons.notifications),
      )
    ]);
  }
}
