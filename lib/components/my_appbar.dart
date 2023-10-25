import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final void Function()? onPressed;
  const MyAppbar(
      {super.key, required this.appbarTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appbarTitle),
      titleTextStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: onPressed),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
