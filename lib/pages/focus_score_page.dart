import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:level/components/all_status.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_button.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/models/level.dart';
import 'package:level/models/user.dart';
import 'package:level/pages/home_page.dart';
import 'package:level/services/user_service.dart';
import 'package:localization/localization.dart';

class FocusScorePage extends StatefulWidget {
  final int categoryId;
  final User oldUser;
  const FocusScorePage(
      {super.key, required this.categoryId, required this.oldUser});

  @override
  State<FocusScorePage> createState() => _FocusScorePageState();
}

class _FocusScorePageState extends State<FocusScorePage> {
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

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              appBar: MyAppbar(
                appbarTitle: "BackToProfile".i18n(),
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, _) {
                      return const HomePage(selectedIndex: 0);
                    },
                  ));
                },
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: ListView(children: [
                  MyTitle(
                      title: "Result".i18n(),
                      titleIcon: const Icon(Icons.show_chart_rounded)),
                  const MyDevider(),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            radius: 57,
                            backgroundImage:
                                const AssetImage('lib/assets/v10.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                          user.username,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lv. ${user.level}"),
                      Text(
                          "Exp. ${user.exp} / ${Level(level: user.level, currentExp: user.exp).maxExp}"),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  FAProgressBar(
                    size: 12,
                    progressColor: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    currentValue: user.exp.toDouble(),
                    animatedDuration: const Duration(milliseconds: 600),
                    maxValue: Level(level: user.level, currentExp: user.exp)
                        .maxExp
                        .toDouble(),
                  ),
                  AllStatus(
                      user: user,
                      categoryId: widget.categoryId,
                      oldUser: widget.oldUser),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                          buttonChild: Text("Confirm".i18n()),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation, _) {
                                return const HomePage(selectedIndex: 0);
                              },
                            ));
                          },
                          buttonBackgroundColor:
                              Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "LongerThanTen".i18n(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ));
                },
                child: Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
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
