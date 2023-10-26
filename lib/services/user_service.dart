import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:level/models/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createUserIfNotExist() async {
    String? userId = await _getId();
    // dynamic userInDb = await _firestore.collection("users").doc(userId).get();
    // print(userId);
    // print(userInDb.toString());

    // if(userInDb != null) return;

    User user = User(
        userId: userId,
        username: "username",
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    dynamic aaa = await _firestore.collection("users").doc(await _getId()).get();
    return await _firestore.collection("users").doc(await _getId()).get();
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
