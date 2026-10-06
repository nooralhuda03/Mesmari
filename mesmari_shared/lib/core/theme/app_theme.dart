import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scaffold = dark ? const Color(0xFF0F1A1C) : const Color(0xFFECF5F7);
    final seed = dark ? const Color(0xFF2FA8A0) : const Color(0xFF004957);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
      ),
      textTheme: GoogleFonts.cairoTextTheme(
        dark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dark ? const Color(0xFF16262A) : Colors.white,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: dark ? const Color(0xFF16262A) : Colors.white,
      ),
    );
  }
}
