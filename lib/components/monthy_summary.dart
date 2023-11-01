import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int> datasets;
  const MonthlySummary({super.key, required this.datasets});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: HeatMapCalendar(
          datasets: datasets,
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
