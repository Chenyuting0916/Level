import 'package:flutter/material.dart';
import 'package:level/components/my_appbar.dart';
import 'package:level/components/my_category.dart';
import 'package:localization/localization.dart';
import 'package:level/models/study_category.dart';

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
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyCategory(
                  categoryName: StudyCategory.all[index + index * 2].name.i18n(),
                  categoryIcon: StudyCategory.all[index + index * 2].icon,
                  categoryId: StudyCategory.all[index + index * 2].id,
                ),
                MyCategory(
                  categoryName: StudyCategory.all[index + 1 + index * 2].name.i18n(),
                  categoryIcon: StudyCategory.all[index + 1 + index * 2].icon,
                  categoryId: StudyCategory.all[index + 1 + index * 2].id,
                ),
                MyCategory(
                  categoryName: StudyCategory.all[index + 2 + index * 2].name.i18n(),
                  categoryIcon: StudyCategory.all[index + 2 + index * 2].icon,
                  categoryId: StudyCategory.all[index + 2 + index * 2].id,
                ),
              ],
            );
          }),
    );
  }
}
