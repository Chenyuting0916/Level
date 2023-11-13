import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_dialog_with_textfield.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:localization/localization.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  var today = DateTime.now();
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(
          appbarTitle: "BackToQuestPage".i18n(),
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return const HomePage(selectedIndex: 2);
              },
            ));
          },
        ),
        body: TableCalendar(
            locale: LocaleProvider().locale.languageCode,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: today,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            headerStyle: const HeaderStyle(titleCentered: true,
            )),
        floatingActionButton: FloatingActionButton(
          heroTag: "NewPlanDialog",
          onPressed: addPlanQuestDialog,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ));
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void addPlanQuestDialog() async {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialogWithTextField(
              controller: textController,
              title: "EnterYourPlan".i18n(),
              hintText: "EnterYourPlan".i18n(),
              onYesPressed: () async {
                textController.clear();
              },
              onNoPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              });
        });
  }
}
