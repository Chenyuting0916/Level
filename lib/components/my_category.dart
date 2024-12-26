import 'package:flutter/material.dart';
import 'package:level/components/my_button.dart';
import 'package:level/components/my_timer.dart';

class MyCategory extends StatelessWidget {
  final String categoryName;
  final Icon categoryIcon;
  final int categoryId;
  const MyCategory(
      {super.key,
      required this.categoryName,
      required this.categoryIcon,
      required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: MyButton(
        buttonBackgroundColor: Colors.transparent,
        buttonChild: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              categoryIcon.icon, // 保留原本的 icon
              color: Theme.of(context).colorScheme.inversePrimary, // 設定顏色，例如設定為藍色
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(
                categoryName,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, _) {
              return MyTimer(
                categoryId: categoryId,
              );
            },
          ));
        },
      ),
    );
  }
}
