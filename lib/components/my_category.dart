import 'package:flutter/material.dart';

class MyCategory extends StatelessWidget {
  final String categoryName;
  final Icon categoryIcon;
  const MyCategory(
      {super.key, required this.categoryName, required this.categoryIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.tertiary,
            elevation: 0,
            splashFactory: NoSplash.splashFactory,
          ),
          
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            categoryIcon,
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
              child: Text(categoryName, style: const TextStyle(fontSize: 14),),
            ),
          ],
        ),
      ),
    );
  }
}
