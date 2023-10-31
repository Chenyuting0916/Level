import 'package:level/models/daily_quest.dart';

class DailyQuests {
  final String? userId;
  final List<DailyQuest> dailyQuests;

  DailyQuests({required this.userId, required this.dailyQuests});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "dailyQuest": dailyQuests.map<Map>((e) => e.toMap()).toList(),
    };
  }

  static DailyQuests fromJson(Map<String, dynamic> json) {
    List<DailyQuest> result = [];
    var dailyQuests = json['dailyQuest'];
    if (dailyQuests is List) {
      result = dailyQuests.map((e) => DailyQuest.fromMap(e)).toList();
    }
    return DailyQuests(
      userId: json['userId'],
      dailyQuests: result,
    );
  }
}