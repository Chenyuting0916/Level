import 'package:flutter/material.dart';

class Language {
  static final all = [
    const Locale('en'),
    const Locale('zh'),
    const Locale('ja'),
  ];

  static getLocaleName(String languageCode) {
    switch (languageCode) {
      case 'zh':
        return "繁體中文";
      case 'en':
        return "English";
      case 'ja':
        return "日本語";
      default:
        return "繁體中文";
    }
  }
}
