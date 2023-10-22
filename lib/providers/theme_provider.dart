import 'package:flutter/material.dart';
import 'package:level/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  void toggleTheme(){
    if(_themeData == lightMode){
      _themeData = darkMode;
    }
    else{
      _themeData = lightMode;
    }
    notifyListeners();
  }
}