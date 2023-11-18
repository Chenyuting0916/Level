import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level/models/reload_days.dart';
import 'package:level/services/auth_service.dart';
import 'package:level/services/user_service.dart';

class FakeSchedulerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = AuthService().currentUser!.uid;

  Future<ReloadDays?> getReloadDays() async {
    var doc = await _firestore.collection('reloadDays').doc(userId).get();

    if (doc.exists) {
      return ReloadDays.fromJson(doc.data()!);
    }
    return null;
  }

  Future resetDataIfNeeded() async {
    var reloadDays = await getReloadDays();
    var now = DateTime.now();
    if (now.isAfter(reloadDays!.weekReloadDate.add(const Duration(days: 7)))) {
      await UserService().updateUser({"weekStudySeconds": 0});
      reloadDays.weekReloadDate = now;
      await updateReloadDays(reloadDays.toMap());
    }

    if (now.isAfter(reloadDays.monthReloadDate.add(const Duration(days: 30)))) {
      await UserService().updateUser({"monthStudySeconds": 0});
      reloadDays.monthReloadDate = now;
      await updateReloadDays(reloadDays.toMap());
    }
  }

  Future updateReloadDays(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('reloadDays').doc(userId);

    snapshot.update(updateData);
  }

  createReloadDaysIfNotExist() async {
    final snapshot =
        await _firestore.collection('reloadDays').doc(userId).get();
    var now = DateTime.now();

    if (!snapshot.exists) {
      var reloadDays =
          ReloadDays(weekReloadDate: now, monthReloadDate: now, userId: userId);

      await _firestore
          .collection("reloadDays")
          .doc(userId)
          .set(reloadDays.toMap());
    }
  }
}
