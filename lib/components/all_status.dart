import 'package:flutter/material.dart';
import 'package:level/components/my_status.dart';

class AllStatus extends StatelessWidget {
  const AllStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only( top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'Strength',
                statusIcon: Icons.do_disturb_off,
                statusValue: "13",
                increased: '3',
              ),
              MyStatus(
                statusName: 'Speed',
                statusIcon: Icons.dnd_forwardslash_rounded,
                statusValue: "15",
                increased: '5',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'Witness',
                statusIcon: Icons.dark_mode_outlined,
                statusValue: "10",
                increased: '',
              ),
              MyStatus(
                statusName: 'Soul',
                statusIcon: Icons.javascript_sharp,
                statusValue: "10",
                increased: '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
