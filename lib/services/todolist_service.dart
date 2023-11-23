import 'package:level/models/todolist.dart';
import 'package:level/services/daily_quest_service.dart';
import 'package:level/services/plan_event_service.dart';

class TodoListService {
  Future<TodoList?> getTodoList() async {
    var dailyQuests = await DailyQuestService().getDailyQuest();
    var events = await PlanEventService().getEvents();
    return TodoList(dailyQuests: dailyQuests, events: events);
  }
}
