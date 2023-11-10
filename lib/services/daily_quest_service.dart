import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level/models/daily_quest.dart';
import 'package:level/models/daily_quests.dart';
import 'package:level/services/auth_service.dart';

class DailyQuestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = AuthService().currentUser!.uid;

  Future<DailyQuests?> getDailyQuest() async {
    final snapshot =
        await _firestore.collection('dailyQuests').doc(userId).get();

    if (snapshot.exists) {
      return DailyQuests.fromJson(snapshot.data()!);
    }
    return null;
  }

  createDailyQuestIfNotExist() async {
    final snapshot =
        await _firestore.collection('dailyQuests').doc(userId).get();

    if (!snapshot.exists) {
      DailyQuests dailyQuest = DailyQuests(userId: userId, dailyQuests: [
        DailyQuest(dailyQuestName: "Morning Run", isCompleted: false),
        DailyQuest(dailyQuestName: "Read Book", isCompleted: false)
      ], datasets: {
        DateTime(1997, 09, 16): 1,
      });

      await _firestore
          .collection("dailyQuests")
          .doc(userId)
          .set(dailyQuest.toMap());
    }
  }

  Future updateDailyQuest(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('dailyQuests').doc(userId);

    snapshot.update(updateData);
  }

  Future completeTask(int index, bool? value) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests[index].isCompleted = value!;
    if (value) {
      dailyQuest.datasets.update(today, (value) => value + 1,
          ifAbsent: () => dailyQuest.datasets[today] = 1);
    } else {
      if (dailyQuest.datasets[today] == 1) {
        dailyQuest.datasets.removeWhere((key, value) => key == today);
      } else {
        dailyQuest.datasets.update(today, (value) => value - 1,
            ifAbsent: () => dailyQuest.datasets[today] = 1);
      }
    }
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future addNewDailyQuest(String questName) async {
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests
        .add(DailyQuest(dailyQuestName: questName, isCompleted: false));
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future editDailyQuest(int index, String questName) async {
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests[index].dailyQuestName = questName;
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future deleteQuest(int index) async {
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests.removeAt(index);
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future<int> getCompletedTasksNumber() async {
    var dailyQuest = await getDailyQuest();
    int sum = 0;
    for (var element in dailyQuest!.datasets.values) {
      sum += element;
    }
    return sum;
  }

  clearYesterdayCompletedDailyQuest() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    var dailyQuest = await getDailyQuest();
    if (!dailyQuest!.datasets.containsKey(today)) {
      for (var d in dailyQuest.dailyQuests) {
        d.isCompleted = false;
      }
    }

    await updateDailyQuest(dailyQuest.toMap());
  }
}
