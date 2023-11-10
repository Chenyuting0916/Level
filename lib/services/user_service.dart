import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:level/models/user.dart';
import 'package:level/services/auth_service.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = AuthService().currentUser!.uid;

  createUserIfNotExist() async {
    final snapshot = await _firestore.collection('users').doc(userId).get();

    if (!snapshot.exists) {
      String rabdomNumber = Random().nextInt(1000).toString();
      MyUser user = MyUser(
          userId: userId,
          username: "user_$rabdomNumber",
          level: 1,
          exp: 1,
          strength: 10,
          wisdom: 10,
          intelligence: 10,
          vitality: 10,
          agility: 10,
          professionalSkill: 10,
          luck: 10,
          financialQuotient: 10,
          seconds: 0,
          loginDays: 1,
          lastLoginDay: DateTime.now(),
          imageUrl: "",
          weekStudySeconds: 0,
          monthStudySeconds: 0);

      await _firestore.collection("users").doc(userId).set(user.toMap());
    }
  }

  // createTestUser() {
  //   String rabdomNumber = Random().nextInt(1000).toString();
  //   int rabdomLevel = Random().nextInt(20);
  //   int rabdomExp = Random().nextInt(5);
  //   int rabdomSeconds = Random().nextInt(800000);

  //   User user = User(
  //       userId: "TestUserId_$rabdomNumber",
  //       username: "test_user_$rabdomNumber",
  //       level: rabdomLevel,
  //       exp: rabdomExp,
  //       strength: 10,
  //       wisdom: 10,
  //       intelligence: 10,
  //       vitality: 10,
  //       agility: 10,
  //       professionalSkill: 10,
  //       luck: 10,
  //       financialQuotient: 10,
  //       seconds: rabdomSeconds,
  //       loginDays: 1,
  //       lastLoginDay: DateTime.now(),
  //       imageUrl: "");

  //   _firestore
  //       .collection("users")
  //       .doc("TestUserId_$rabdomNumber")
  //       .set(user.toMap());
  // }

  Future<MyUser?> getCurrentUser() async {
    final snapshot = await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return MyUser.fromJson(snapshot.data()!);
    }
    return null;
  }

  Stream<List<MyUser>> getRankedUsers() {
    return _firestore
        .collection('users')
        .orderBy("level", descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MyUser.fromJson(doc.data())).toList());
  }

  Future updateUser(Map<String, dynamic> updateData) async {
    final snapshot = _firestore.collection('users').doc(userId);

    snapshot.update(updateData);
  }

  updateLoginDay() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    MyUser? user = await getCurrentUser();
    var last = DateTime(
      user!.lastLoginDay.year,
      user.lastLoginDay.month,
      user.lastLoginDay.day,
    );

    if (last == today) return;

    await updateUser(
        {"lastLoginDay": DateTime.now(), "loginDays": user.loginDays + 1});
  }
}
