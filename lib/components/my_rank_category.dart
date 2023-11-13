import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MyRankCategory extends StatelessWidget {
  final String categoryName;
  final String filterName;
  final bool isSelected;
  final Function(dynamic) onTap;

  const MyRankCategory(
      {super.key,
      required this.categoryName,
      required this.filterName,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            onTap(filterName);
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueGrey.shade400 : Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(48.0)),
            ),
            child: Text(
              categoryName.i18n(),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        )
      ],
    );
  }
}
