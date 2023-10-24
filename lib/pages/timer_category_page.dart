import 'package:flutter/material.dart';
import 'package:level/components/my_category.dart';
import 'package:localization/localization.dart';

class TimerCategoryPage extends StatelessWidget {
  const TimerCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.tertiary,
        ),
        titleTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.tertiary),
        title: Text("StartFocus".i18n()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCategory(
                  categoryName: "Exercises".i18n(),
                  categoryIcon: const Icon(
                    Icons.directions_walk_sharp,
                  )),
              MyCategory(
                  categoryName: "Study".i18n(),
                  categoryIcon: const Icon(
                    Icons.school,
                  )),
              MyCategory(
                  categoryName: "Mindfulness".i18n(),
                  categoryIcon: const Icon(
                    Icons.terrain_rounded,
                  )),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCategory(
                  categoryName: "Art".i18n(),
                  categoryIcon: const Icon(
                    Icons.bubble_chart,
                  )),
              MyCategory(
                  categoryName: "Work".i18n(),
                  categoryIcon: const Icon(
                    Icons.attach_money_rounded,
                  )),
              MyCategory(
                  categoryName: "Code".i18n(),
                  categoryIcon: const Icon(
                    Icons.code,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
