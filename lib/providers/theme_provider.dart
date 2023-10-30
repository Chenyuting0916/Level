import 'package:flutter/material.dart';
import 'package:level/services/local_storage_service.dart';
import 'package:level/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeData get themeData => _themeData ?? getDefaultThemeData();
  var localStorageService = LocalStorageService();

  void toggleTheme() async {
    if (_themeData == lightMode) {
      _themeData = darkMode;
      localStorageService.writeData("LightMode", false);
    } else {
      _themeData = lightMode;
      localStorageService.writeData("LightMode", true);
    }
    notifyListeners();
  }

  ThemeData getDefaultThemeData() {
    if (localStorageService.getData("LightMode") == null) {
      localStorageService.createInitialThemeMode();
    } else if (localStorageService.getData("LightMode")) {
      return lightMode;
    }
    return darkMode;
  }
}
