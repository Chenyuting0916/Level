class DailyQuest {
  final String dailyQuestName;
  bool isCompleted;

  DailyQuest({required this.dailyQuestName, required this.isCompleted});

  Map<String, dynamic> toMap() {
    return {
      'dailyQuestName': dailyQuestName,
      'isCompleted': isCompleted,
    };
  }

  static DailyQuest fromMap(Map<String, dynamic> map) {
    return DailyQuest(
      dailyQuestName: map['dailyQuestName'],
      isCompleted: map['isCompleted'],
    );
  }
}