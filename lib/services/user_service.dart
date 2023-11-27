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
          monthStudySeconds: 0,
          premium: false);

      await _firestore.collection("users").doc(userId).set(user.toMap());
    }
  }

  Future<MyUser?> getCurrentUser() async {
    return await getUser(userId);
  }

  Future<List<MyUser>> getRankedUsers(String filter) async {
    List<QueryDocumentSnapshot> docs = await _firestore
        .collection('users')
        .orderBy(filter, descending: true)
        .limit(10)
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs);

    List<MyUser> users = docs
        .map((doc) => MyUser.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return users;
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

  Future<MyUser?> getUser(String? id) async {
    final snapshot = await _firestore.collection('users').doc(id).get();

    if (snapshot.exists) {
      return MyUser.fromJson(snapshot.data()!);
    }
    return null;
  }

  Future<int> getSelfRank(String filter) async {
    var self = await getCurrentUser();
    var docs = await _firestore
        .collection('users')
        .where(filter, isGreaterThanOrEqualTo: self!.getProperty(filter))
        .get()
        .then((QuerySnapshot snapshot) => snapshot.docs);

    return docs.toList().length;
  }
}
