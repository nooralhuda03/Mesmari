import 'dart:ui';

import 'package:flutter/material.dart';

/// Light / dark / follow-the-system. Changing it rebuilds the whole app.
class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  ThemeMode _mode = ThemeMode.light;

  ThemeMode get mode => _mode;

  /// Whether dark colours should be used right now.
  bool get isDark => switch (_mode) {
    ThemeMode.dark => true,
    ThemeMode.light => false,
    ThemeMode.system =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark,
  };

  void setMode(ThemeMode mode) {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
  }
}
