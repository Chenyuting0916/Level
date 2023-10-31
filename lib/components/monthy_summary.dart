import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatelessWidget {
  const MonthlySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: HeatMapCalendar(
          datasets: {
            DateTime(2023, 10, 26): 1,
            DateTime(2023, 10, 27): 2,
            DateTime(2023, 10, 28): 0,
            DateTime(2023, 10, 30): 1,
          },
          fontSize: 10,
          size: 25,
          initDate: DateTime.now(),
          colorMode: ColorMode.opacity,
          textColor: Theme.of(context).colorScheme.tertiary,
          defaultColor: Theme.of(context).colorScheme.primary,
          colorsets: const {
            1: Colors.green,
          },
          showColorTip: false),
    );
  }
}
