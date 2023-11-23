import 'package:level/models/daily_quests.dart';
import 'package:level/models/event.dart';

class TodoList {
  final DailyQuests? dailyQuests;
  final List<Event>? events;

  TodoList({required this.dailyQuests, required this.events});
}
