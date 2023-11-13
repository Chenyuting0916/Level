class StatusCategory {
  final String translationShortName;
  final String databaseName;

  StatusCategory(
      {required this.databaseName, required this.translationShortName});

  static final all = [
    StatusCategory(
      translationShortName: 'STR',
      databaseName: 'strength',
    ),
    StatusCategory(
      translationShortName: 'INT',
      databaseName: 'intelligence',
    ),
    StatusCategory(
      translationShortName: 'WIS',
      databaseName: 'wisdom',
    ),
    StatusCategory(
      translationShortName: 'AGI',
      databaseName: 'agility',
    ),
    StatusCategory(
      translationShortName: 'LUK',
      databaseName: 'luck',
    ),
    StatusCategory(
      translationShortName: 'VIT',
      databaseName: 'vitality',
    ),
    StatusCategory(
      translationShortName: 'PS',
      databaseName: 'professionalSkill',
    ),
    StatusCategory(
      translationShortName: 'FQ',
      databaseName: 'financialQuotient',
    ),
  ];
}
