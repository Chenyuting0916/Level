import 'dart:io';
import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:level/models/language.dart';

class LocalStorageService {
  final _myBox = Hive.box('settings');

  void writeData(dynamic key, dynamic value) {
    _myBox.put(key, value);
  }

  void createInitialLocale() {
    String languageCode = Platform.localeName.split('_')[0];

    if (Language.all.contains(Locale(languageCode))) {
      _myBox.put("Language", Locale(languageCode).toLanguageTag());
    } else {
      _myBox.put("Language", const Locale('zh').toLanguageTag());
    }
  }

  void createInitialThemeMode() {
    _myBox.put("LightMode", false);
  }

  dynamic getData(dynamic key) {
    return _myBox.get(key);
  }
}
