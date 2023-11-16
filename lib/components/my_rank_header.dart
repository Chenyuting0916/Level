import 'package:flutter/material.dart';
import 'package:level/components/my_rank_category.dart';
import 'package:level/models/status_category.dart';

class MyRankHeader extends StatefulWidget {
  const MyRankHeader(
      {super.key, required this.onTap, required this.currentSelected});
  final String currentSelected;
  final Function(dynamic) onTap;

  @override
  State<MyRankHeader> createState() => _MyRankHeaderState();
}

class _MyRankHeaderState extends State<MyRankHeader> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    jumpToOffset();
    super.initState();
  }

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
                controller: scrollController,
                children: [
                  MyRankCategory(
                    categoryName: 'Level',
                    isSelected: isSelected('level'),
                    onTap: widget.onTap,
                    filterName: 'level',
                  ),
                  MyRankCategory(
                    categoryName: 'Time',
                    isSelected: isSelected('seconds'),
                    onTap: widget.onTap,
                    filterName: 'seconds',
                  ),
                  ...StatusCategory.all.map((category) {
                    return MyRankCategory(
                      categoryName: category.translationShortName,
                      isSelected: isSelected(category.databaseName),
                      onTap: widget.onTap,
                      filterName: category.databaseName,
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

  isSelected(String category) {
    return widget.currentSelected == category;
  }

  jumpToOffset() {
    scrollController = ScrollController(
      initialScrollOffset: [
        "luck",
        "vitality",
        "professionalSkill",
        "financialQuotient"
      ].contains(widget.currentSelected)
          ? 200
          : 0,
      keepScrollOffset: true,
    );
  }
}
