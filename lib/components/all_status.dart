import 'package:flutter/material.dart';
import 'package:level/components/my_status.dart';
import 'package:localization/localization.dart';

class AllStatus extends StatelessWidget {
  const AllStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'STR'.i18n(),
                statusIcon: Icons.fitness_center,
                statusValue: "13",
                increased: '3',
                tooltipMessage: "Strength".i18n(),
              ),
              MyStatus(
                statusName: 'WIS'.i18n(),
                statusIcon: Icons.terrain_rounded,
                statusValue: "10",
                increased: '',
                tooltipMessage: "Wisdom".i18n(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'INT'.i18n(),
                statusIcon: Icons.school,
                statusValue: "10",
                increased: '',
                tooltipMessage: "Intelligence".i18n(),
              ),
              MyStatus(
                statusName: 'VIT'.i18n(),
                statusIcon: Icons.sentiment_satisfied_outlined,
                statusValue: "15",
                increased: '5',
                tooltipMessage: "Vitality".i18n(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'AGI'.i18n(),
                statusIcon: Icons.directions_run_outlined,
                statusValue: "12",
                increased: '2',
                tooltipMessage: "Agility".i18n(),
              ),
              MyStatus(
                statusName: 'PS'.i18n(),
                statusIcon: Icons.trending_up_rounded,
                statusValue: "10",
                increased: '',
                tooltipMessage: "ProfessionalSkill".i18n(),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'LUK'.i18n(),
                statusIcon: Icons.currency_bitcoin,
                statusValue: "10",
                increased: '',
                tooltipMessage: "Luck".i18n(),
              ),
              MyStatus(
                statusName: 'FQ'.i18n(),
                statusIcon: Icons.attach_money_outlined,
                statusValue: "10",
                increased: '',
                tooltipMessage: "FinancialQuotient".i18n(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
