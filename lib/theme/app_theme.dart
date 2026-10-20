import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Soft & Elegant Green Palette
  static const Color primary = Color(0xFF1B7A4E);
  static const Color primaryLight = Color(0xFF2E9B6A);
  static const Color softBg = Color(0xFFF4F9F6);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1A2E28);
  static const Color textGrey = Color(0xFF5F6F68);
  static const Color accent = Color(0xFFE8A838); // soft gold/orange
  static const Color success = Color(0xFF2E9B6A);
  static const Color danger = Color(0xFFE57373);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: softBg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: primaryLight,
      surface: cardBg,
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headlineLarge: GoogleFonts.inter(fontWeight: FontWeight.w700, color: textDark),
      headlineMedium: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textDark),
      titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w600, color: textDark),
      bodyLarge: GoogleFonts.inter(color: textDark),
      bodyMedium: GoogleFonts.inter(color: textGrey),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}