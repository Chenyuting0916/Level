import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:level/components/all_status.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_divider.dart';
import 'package:level/components/my_title.dart';
import 'package:level/pages/home_page.dart';
import 'package:localization/localization.dart';

class FocusScorePage extends StatefulWidget {
  const FocusScorePage({super.key});

  @override
  State<FocusScorePage> createState() => _FocusScorePageState();
}

class _FocusScorePageState extends State<FocusScorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 57,
                    backgroundImage: const AssetImage('lib/assets/v10.png'),
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                const Text(
                  "User_6969",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Lv. 1"),
              Text("Exp. 6 / 10"),
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
            currentValue: 6,
            animatedDuration: const Duration(milliseconds: 600),
            maxValue: 10,
          ),
          const AllStatus(),
        ]),
      ),
    );
  }
}
