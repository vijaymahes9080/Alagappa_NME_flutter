import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_strings.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLocale = 'en';

  String get currentLocale => _currentLocale;
  bool get isTamil => _currentLocale == 'ta';

  LanguageProvider() {
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLocale = prefs.getString('language_code') ?? 'en';
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _currentLocale = _currentLocale == 'en' ? 'ta' : 'en';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', _currentLocale);
    notifyListeners();
  }

  String translate(String key) {
    return AppStrings.get(key, _currentLocale);
  }
}
