import 'package:flutter/material.dart';

/// The app's current language. Changing it rebuilds the whole app.
class LocaleController extends ChangeNotifier {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  static const supported = [Locale('ar'), Locale('en')];

  Locale _locale = const Locale('ar');

  Locale get locale => _locale;

  String get languageCode => _locale.languageCode;

  bool get isArabic => _locale.languageCode == 'ar';

  void setLanguage(String code) {
    if (code == _locale.languageCode) return;
    _locale = Locale(code);
    notifyListeners();
  }
}
