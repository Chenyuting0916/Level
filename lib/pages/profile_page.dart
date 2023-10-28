import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_headshot_username.dart';
import 'package:level/components/my_level.dart';
import 'package:level/components/my_row_status.dart';
import 'package:level/components/my_title.dart';
import 'package:level/models/user.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
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

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: ListView(
                children: [
                  MyTitle(
                      title: "Profile".i18n(),
                      titleIcon: const Icon(Icons.person)),
                  const MyDevider(),
                  MyHeadshotAndUsername(
                    imageUrl: 'lib/assets/v10.png',
                    username: user.username,
                  ),
                  MyLevel(level: user.level, exp: user.exp),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                            "LoginDays".i18n([user.loginDays.toString()]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child:
                        BarChart(BarChartData(maxY: 100, minY: 0, barGroups: [
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(toY: 66, fromY: 0, color: Colors.amber)
                      ]),
                    ])),
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