import 'package:level/models/daily_quest.dart';

class DailyQuests {
  final String? userId;
  final List<DailyQuest> dailyQuests;
  final Map<DateTime, int> datasets;

  DailyQuests(
      {required this.userId,
      required this.dailyQuests,
      required this.datasets});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "dailyQuest": dailyQuests.map<Map>((e) => e.toMap()).toList(),
      "datasets": datasets.map((k, v) => MapEntry('$k', v))
    };
  }

  static DailyQuests fromJson(Map<String, dynamic> json) {
    List<DailyQuest> dailyQuests = [];
    var dailyQuestsJson = json['dailyQuest'];
    if (dailyQuestsJson is List) {
      dailyQuests = dailyQuestsJson.map((e) => DailyQuest.fromMap(e)).toList();
    }

    var datasets = <DateTime, int>{};

    json['datasets'].forEach((k, v) {
      var key = DateTime.parse(k);
      datasets[key] = v;
    });

    return DailyQuests(
        userId: json['userId'], dailyQuests: dailyQuests, datasets: datasets);
  }
}
