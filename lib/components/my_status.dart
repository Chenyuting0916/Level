import 'package:flutter/material.dart';

class MyStatus extends StatelessWidget {
  final IconData statusIcon;
  final String statusName;
  final String increased;
  final String statusValue;

  const MyStatus(
      {super.key,
      required this.statusName,
      required this.statusIcon,
      required this.statusValue,
      required this.increased});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                statusIcon,
                size: 60,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(statusName)
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            statusValue,
            style: const TextStyle(fontSize: 24),
          ),
          buildIncreasedIcon(),
        ],
      ),
    );
  }

  Widget buildIncreasedIcon() {

    if(increased == '') return const SizedBox(width: 25,);
    return Column(
      children: [
        const SizedBox(
          width: 25,
          height: 10,
        ),
        Row(
          children: [
            Text(
              "( $increased",
              style: const TextStyle(fontSize: 10),
            ),
            const Icon(
              Icons.arrow_upward_sharp,
              size: 10,
            ),
            const Text(
              ")",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
