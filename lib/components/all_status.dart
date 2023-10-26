import 'package:flutter/material.dart';
import 'package:level/components/my_status.dart';
import 'package:level/models/user.dart';
import 'package:localization/localization.dart';

class AllStatus extends StatelessWidget {
  final User user;
  const AllStatus({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: Wrap(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyStatus(
                statusName: 'STR'.i18n(),
                statusIcon: Icons.fitness_center,
                statusValue: "${user.strength}",
                increased: '3',
                tooltipMessage: "Strength".i18n(),
              ),
              MyStatus(
                statusName: 'WIS'.i18n(),
                statusIcon: Icons.terrain_rounded,
                statusValue: "${user.wisdom}",
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
                statusValue: "${user.intelligence}",
                increased: '',
                tooltipMessage: "Intelligence".i18n(),
              ),
              MyStatus(
                statusName: 'VIT'.i18n(),
                statusIcon: Icons.sentiment_satisfied_outlined,
                statusValue: "${user.vitality}",
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
                statusValue: "${user.agility}",
                increased: '2',
                tooltipMessage: "Agility".i18n(),
              ),
              MyStatus(
                statusName: 'PS'.i18n(),
                statusIcon: Icons.trending_up_rounded,
                statusValue: "${user.professionalSkill}",
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
                statusValue: "${user.luck}",
                increased: '',
                tooltipMessage: "Luck".i18n(),
              ),
              MyStatus(
                statusName: 'FQ'.i18n(),
                statusIcon: Icons.attach_money_outlined,
                statusValue: "${user.financialQuotient}",
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
