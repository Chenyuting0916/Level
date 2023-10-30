import 'dart:ui';

import 'package:hive/hive.dart';

class LocalStorageService {
  final _myBox = Hive.box('settings');

  void writeData(dynamic key, dynamic value) {
    _myBox.put(key, value);
  }

  void createInitialLocale() {
    _myBox.put("Language", const Locale('zh').toLanguageTag());
  }

  void createInitialThemeMode() {
    _myBox.put("LightMode", false);
  }

  dynamic getData(dynamic key) {
    return _myBox.get(key);
  }
}
