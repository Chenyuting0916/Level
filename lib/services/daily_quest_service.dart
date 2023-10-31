import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:level/models/daily_quest.dart';
import 'package:level/models/daily_quests.dart';

class DailyQuestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DailyQuests?> getDailyQuest() async {
    String? userId = await _getId();
    final snapshot =
        await _firestore.collection('dailyQuests').doc(userId).get();

    if (snapshot.exists) {
      return DailyQuests.fromJson(snapshot.data()!);
    }
    return null;
  }

  createDailyQuestIfNotExist() async {
    String? userId = await _getId();
    final snapshot =
        await _firestore.collection('dailyQuests').doc(userId).get();

    if (!snapshot.exists) {
      DailyQuests dailyQuest = DailyQuests(userId: userId, dailyQuests: [
        DailyQuest(dailyQuestName: "Morning Run", isCompleted: false),
        DailyQuest(dailyQuestName: "Read Book", isCompleted: false)
      ]);

      await _firestore
          .collection("dailyQuests")
          .doc(userId)
          .set(dailyQuest.toMap());
    }
  }

  Future updateDailyQuest(Map<String, dynamic> updateData) async {
    String? userId = await _getId();
    final snapshot = _firestore.collection('dailyQuests').doc(userId);

    snapshot.update(updateData);
  }

  Future completeTask(int index, bool? value) async {
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests[index].isCompleted = value!;
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future addNewDailyQuest(String questName) async {
    var dailyQuest = await getDailyQuest();
    dailyQuest!.dailyQuests
        .add(DailyQuest(dailyQuestName: questName, isCompleted: false));
    await updateDailyQuest(dailyQuest.toMap());
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
    return null;
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
}
