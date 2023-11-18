import 'package:flutter/material.dart';
import 'package:level/models/title_dropdown.dart';

class MyTitleWithDropDown extends StatelessWidget {
  final Icon titleIcon;
  final String currentTitleValue;
  final List<TitleDropDown> titleDropdown;
  const MyTitleWithDropDown(
      {super.key,
      required this.currentTitleValue,
      required this.titleIcon,
      required this.titleDropdown});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      titleIcon,
      const SizedBox(width: 8),
      DropdownButton<String>(
          value: currentTitleValue,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          items: [
            ...titleDropdown.map(
              (e) => DropdownMenuItem(value: e.value, child: Text(e.name)),
            )
          ],
          onChanged: (value) {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, _) {
                return titleDropdown
                    .where((element) => element.value == value)
                    .first
                    .jumpPage;
              },
            ));
          }),
    ]);
  }
}
