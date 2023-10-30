import 'package:flutter/material.dart';
import 'package:level/models/language.dart';
import 'package:level/services/local_storage_service.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  var localStorageService = LocalStorageService();

  Locale getDefaultLocale() {
    if (localStorageService.getData("Language") == null) {
      localStorageService.createInitialLocale();
    }

    return Locale(localStorageService.getData("Language"));
  }

  Locale get locale => _locale ?? getDefaultLocale();

  void setLocale(Locale locale) {
    if (!Language.all.contains(locale)) return;

    _locale = locale;
    localStorageService.writeData("Language", locale.toLanguageTag());
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
