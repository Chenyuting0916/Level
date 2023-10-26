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
      return fromJson(snapshot.data()!);
    }
  }

  Stream<List<User>> getRankedUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => fromJson(doc.data())).toList());
  }

  void updateUser(Map<String, dynamic> updateData) async {
    String? userId = await _getId();
    final snapshot = _firestore.collection('users').doc(userId);

    snapshot.update(updateData);
  }

  static User fromJson(Map<String, dynamic> json) => User(
      userId: json['userId'],
      username: json['username'],
      level: json['level'],
      strength: json['strength'],
      wisdom: json['wisdom'],
      intelligence: json['intelligence'],
      vitality: json['vitality'],
      agility: json['agility'],
      professionalSkill: json['professionalSkill'],
      luck: json['luck'],
      financialQuotient: json['financialQuotient'],
      seconds: json['seconds']);

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
