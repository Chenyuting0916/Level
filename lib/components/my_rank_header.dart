import 'package:flutter/material.dart';
import 'package:level/components/my_rank_category.dart';
import 'package:level/models/status_category.dart';
import 'package:localization/localization.dart';

class MyRankHeader extends StatefulWidget {
  const MyRankHeader({super.key});

  @override
  State<MyRankHeader> createState() => _MyRankHeaderState();
}

class _MyRankHeaderState extends State<MyRankHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  MyRankCategory(
                      categoryName: 'Level'.i18n(),
                      isSelected: true,
                      onTap: () {},
                    ),
                  ...StatusCategory.all.map((category) {
                    return MyRankCategory(
                      categoryName: category.i18n(),
                      isSelected: false,
                      onTap: () {},
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
