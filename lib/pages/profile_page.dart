import 'package:flutter/material.dart';
import 'package:level/components/my_bar_chart.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_headshot_username.dart';
import 'package:level/components/my_level.dart';
import 'package:level/components/my_row_status.dart';
import 'package:level/components/my_title.dart';
import 'package:level/models/user.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser?>(
      future: UserService().getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          final minutes = (user.seconds / 60).toStringAsFixed(2);
          final weekMinutes = (user.weekStudySeconds / 60).toStringAsFixed(2);
          final monthMinutes = (user.monthStudySeconds / 60).toStringAsFixed(2);

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: ListView(
                children: [
                  MyTitle(
                      title: "Profile".i18n(),
                      titleIcon: const Icon(Icons.person)),
                  const MyDivider(),
                  MyHeadshotAndUsername(
                    imageUrl: user.imageUrl,
                    username: user.username,
                  ),
                  MyLevel(
                    level: user.level,
                    exp: user.exp,
                    oldLevel: user.level,
                    learningSeconds: 0,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          MyRowStatus(
                              statusName: "STR".i18n(), status: user.strength),
                          MyRowStatus(
                              statusName: "WIS".i18n(), status: user.wisdom),
                          MyRowStatus(
                              statusName: "INT".i18n(),
                              status: user.intelligence),
                          MyRowStatus(
                              statusName: "AGI".i18n(), status: user.agility),
                          MyRowStatus(
                              statusName: "LUK".i18n(), status: user.luck),
                          MyRowStatus(
                              statusName: "VIT".i18n(), status: user.vitality),
                          MyRowStatus(
                              statusName: "PS".i18n(),
                              status: user.professionalSkill),
                          MyRowStatus(
                              statusName: "FQ".i18n(),
                              status: user.financialQuotient),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "TimeSpend".i18n([minutes]),
                          ),
                          Text(
                            "MonthTimeSpend".i18n([monthMinutes]),
                          ),
                          Text(
                            "WeekTimeSpend".i18n([weekMinutes]),
                          ),
                          Text(
                            "LoginDays".i18n([user.loginDays.toString()]),
                          ),
                          FutureBuilder<int>(
                              future:
                                  DailyQuestService().getCompletedTasksNumber(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final finishedTasks = snapshot.data!;
                                  return Text(
                                    "FinishedTasks"
                                        .i18n([(finishedTasks - 1).toString()]),
                                  );
                                } else {
                                  return Center(
                                      child: Text("NoDataFound".i18n()));
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: MyBarChart(
                      user: user,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text("NoDataFound".i18n()));
        }
      },
    );
  }
}
