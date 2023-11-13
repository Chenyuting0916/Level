import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  Future<InitializationStatus> initialization;

  AdMobService(this.initialization);

  String? get rewardedAdUnitId {
    if (kReleaseMode) {
      if (Platform.isIOS) {
        return "ca-app-pub-8569537755937952/8950808233";
      } else if (Platform.isAndroid) {
        return "ca-app-pub-8569537755937952/4042134471";
      }
    } else {
      return "ca-app-pub-3940256099942544/5224354917";
    }
    return null;
  }
}
