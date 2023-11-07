import 'package:flutter/material.dart';
import 'package:level/components/all_status.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_button.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_headshot_username.dart';
import 'package:level/components/my_hint.dart';
import 'package:level/components/my_level.dart';
import 'package:level/components/my_title.dart';
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
                  const MyDivider(),
                  MyHeadshotAndUsername(
                    imageUrl: user.imageUrl,
                    username: user.username,
                  ),
                  MyLevel(
                    level: user.level,
                    exp: user.exp,
                    oldLevel: widget.oldUser.level,
                    learningSeconds: user.seconds - widget.oldUser.seconds,
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
              floatingActionButton: MyHint(hintMessage: "LongerThanTen".i18n()),
            ),
          );
        } else {
          return Center(child: Text("NoDataFound".i18n()));
        }
      },
    );
  }
}
