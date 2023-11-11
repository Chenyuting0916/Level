import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/pages/home_page.dart';
import 'package:localization/localization.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

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
    );
  }
}
