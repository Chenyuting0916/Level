import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_category.dart';
import 'package:localization/localization.dart';

class TimerCategoryPage extends StatelessWidget {
  const TimerCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        appbarTitle: "StartFocus".i18n(),
        onPressed: () {
          Navigator.of(context).pop();
        },
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
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyCategory(
                  categoryName: "LearnLanguage".i18n(),
                  categoryIcon: const Icon(
                    Icons.language,
                  )),
              MyCategory(
                  categoryName: "StartABusiness".i18n(),
                  categoryIcon: const Icon(
                    Icons.business_sharp,
                  )),
              MyCategory(
                  categoryName: "FinancialLiteracy".i18n(),
                  categoryIcon: const Icon(
                    Icons.credit_card,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
