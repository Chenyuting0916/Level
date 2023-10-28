import 'package:flutter/material.dart';

class MyRowStatus extends StatelessWidget {
  final String statusName;
  final int status;
  const MyRowStatus(
      {super.key, required this.statusName, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: SizedBox(
            width: 100.0,
            child: Text(statusName),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: SizedBox(
            width: 35.0,
            child: Text("$status"),
          ),
        )
      ],
    );
  }
}
