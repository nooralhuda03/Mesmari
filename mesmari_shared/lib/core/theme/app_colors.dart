import 'package:flutter/material.dart';

import 'theme_controller.dart';

/// Colour tokens from the Mesmari Figma file, with a dark variant for each.
///
/// They are getters (not constants) so the whole app re-colours when the
/// theme changes.
class AppColors {
  AppColors._();

  static bool get _dark => ThemeController.instance.isDark;

  static Color _pick(Color light, Color dark) => _dark ? dark : light;

  // Surfaces
  static Color get bg =>
      _pick(const Color(0xFFECF5F7), const Color(0xFF0F1A1C));
  static Color get card => _pick(Colors.white, const Color(0xFF16262A));
  static Color get surface =>
      _pick(const Color(0xFFF9FDFD), const Color(0xFF16262A));
  static Color get surfaceAlt =>
      _pick(const Color(0xFFDEEDEF), const Color(0xFF1E3136));

  // Brand
  static Color get primary =>
      _pick(const Color(0xFF004957), const Color(0xFF2FA8A0));
  static Color get teal =>
      _pick(const Color(0xFF00797B), const Color(0xFF35B3AE));
  static Color get deepTeal =>
      _pick(const Color(0xFF005A5C), const Color(0xFF2C8F90));
  static Color get blue =>
      _pick(const Color(0xFF1B5F80), const Color(0xFF4B9BC4));
  static Color get mint =>
      _pick(const Color(0xFFB8E9E8), const Color(0xFF17403F));
  static Color get blueSoft =>
      _pick(const Color(0xFFCFE5F3), const Color(0xFF1B3A4C));

  // Text
  static Color get text =>
      _pick(const Color(0xFF0A1820), const Color(0xFFE9F1F2));
  static Color get muted =>
      _pick(const Color(0xFF526065), const Color(0xFF9CB2B6));
  static Color get navInactive =>
      _pick(const Color(0xFFA3A3A3), const Color(0xFF7C9296));

  // Lines
  static Color get border =>
      _pick(const Color(0xFFC7D8DA), const Color(0xFF294043));
  static Color get cardBorder =>
      _pick(const Color(0xFFE1E1E1), const Color(0xFF24383C));
  static Color get tileBorder =>
      _pick(const Color(0xFFE9E9E9), const Color(0xFF24383C));

  // States
  static Color get danger =>
      _pick(const Color(0xFFBF534E), const Color(0xFFE5807B));
  static Color get dangerBg =>
      _pick(const Color(0xFFFFF6F5), const Color(0xFF3A2523));
  static Color get red =>
      _pick(const Color(0xFFFF0004), const Color(0xFFFF6B6E));
  static Color get successBg =>
      _pick(const Color(0xFFE8FFFF), const Color(0xFF10312F));

  // Auth screens
  static Color get authTitle =>
      _pick(const Color(0xFF241C16), const Color(0xFFE9F1F2));
  static Color get authBody =>
      _pick(const Color(0xFF6B5D4C), const Color(0xFF9CB2B6));
  static Color get inputBorder =>
      _pick(const Color(0xFFE8EBE6), const Color(0xFF2A3F43));
  static Color get hint =>
      _pick(const Color(0xFF91958E), const Color(0xFF7C9296));
}
