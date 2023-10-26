import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:level/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createUserIfNotExist() async {
    String? userId = await _getId();
    final snapshot = await _firestore.collection('users').doc(userId).get();

    if (!snapshot.exists) {
      String rabdomNumber = Random().nextInt(1000).toString();
      User user = User(
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
          seconds: 0);

      await _firestore.collection("users").doc(userId).set(user.toMap());
    }
  }

  Future<User?> getCurrentUser() async {
    String? userId = await _getId();
    final snapshot = await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    return null;
  }

  Stream<List<User>> getRankedUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
  }

  void updateUser(Map<String, dynamic> updateData) async {
    String? userId = await _getId();
    final snapshot = _firestore.collection('users').doc(userId);

    snapshot.update(updateData);
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
}
