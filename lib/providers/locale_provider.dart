import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  
  LocaleProvider() {
    _loadLocalePreference();
  }
  
  // Dil tercihini yükle
  Future<void> _loadLocalePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(AppConstants.keyLocale);
    
    if (localeCode != null) {
      _locale = Locale(localeCode);
    } else {
      // Sistem dilini kontrol et
      _locale = _getSystemLocale();
    }
    notifyListeners();
  }
  
  // Sistem dilini al (TR/EN)
  Locale _getSystemLocale() {
    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    if (systemLocale.languageCode == 'tr') {
      return const Locale('tr');
    }
    return const Locale('en');
  }
  
  // Dili değiştir
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyLocale, locale.languageCode);
    notifyListeners();
  }
}
