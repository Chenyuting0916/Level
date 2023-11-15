import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_dialog_with_textfield.dart';
import 'package:level/models/event.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/providers/locale_provider.dart';
import 'package:level/services/plan_event_service.dart';
import 'package:localization/localization.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  var _selectedDay = DateTime.now();
  final textController = TextEditingController();
  List<Event> events = [];

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
        body: FutureBuilder(
            future: PlanEventService().getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                events = snapshot.data!;

                return Column(
                  children: [
                    TableCalendar(
                      daysOfWeekHeight: 20,
                      locale: LocaleProvider().locale.languageCode,
                      firstDay: DateTime.utc(2010, 9, 16),
                      lastDay: DateTime.utc(2030, 11, 28),
                      focusedDay: _selectedDay,
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month'
                      },
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                      ),
                      eventLoader: _listOfEvents,
                      calendarBuilders: CalendarBuilders(
                        singleMarkerBuilder: (context, date, _) {
                          return Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary), //change color
                            width: 5.0,
                            height: 5.0,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                          );
                        }
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text("NoDataFound".i18n()));
              }
            }),
        floatingActionButton: FloatingActionButton(
          heroTag: "NewPlanDialog",
          onPressed: addPlanQuestDialog,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
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
                await PlanEventService()
                    .addEvent(textController.text, _selectedDay);
                textController.clear();
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              onNoPressed: () {
                textController.clear();
                Navigator.of(context).pop();
              });
        });
  }

  List<Event> _listOfEvents(DateTime day) {
    var thisDayEvents =
        events.where((element) => isSameDay(element.eventDate, day)).toList();
    if (thisDayEvents.isNotEmpty) {
      return thisDayEvents;
    }
    return [];
  }
}
