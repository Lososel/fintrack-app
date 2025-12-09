import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();
  factory LanguageService() => _instance;
  LanguageService._internal();

  Locale _currentLocale = const Locale('en'); // Default to English

  Locale get currentLocale => _currentLocale;

  String get currentLanguageCode => _currentLocale.languageCode;

  void setLanguage(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      notifyListeners();
    }
  }

  void setLanguageByCode(String languageCode) {
    setLanguage(Locale(languageCode));
  }
}
