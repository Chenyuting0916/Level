import 'package:flutter/material.dart';
import 'package:level/classes/language.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale defaultLocale = const Locale('zh');

  Locale get locale => _locale ?? defaultLocale;

  void setLocale(Locale locale) {
    if (!Language.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
