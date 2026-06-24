import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleTheme {
  // Brand colors for the two dark-tech modes
  static const Color spaceBlue = Color(0xFF4361EE);
  static const Color spaceCyan = Color(0xFF4CC9F0);
  static const Color quantumViolet = Color(0xFF9D4EDD);
  static const Color quantumMagenta = Color(0xFFF72585);

  // Theme 1: Deep Space Navy (Blue & Cyan Accent)
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: spaceBlue,
        secondary: spaceCyan,
        surface: Color(0xFF0B0A1A),
        surfaceContainerHighest: Color(0xFF13112E),
        outline: Color(0xFF26224D),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF030014), // Deep Space Navy base
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        bodyMedium: GoogleFonts.inter(
          textStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300),
        ),
        bodyLarge: GoogleFonts.inter(
          textStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w400),
        ),
        titleLarge: GoogleFonts.outfit(
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        displayMedium: GoogleFonts.outfit(
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.02),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.06), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: spaceBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }

  // Theme 2: Quantum Violet (Violet & Magenta Accent)
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: quantumViolet,
        secondary: quantumMagenta,
        surface: Color(0xFF0F071D),
        surfaceContainerHighest: Color(0xFF190C2F),
        outline: Color(0xFF33195C),
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF070014), // Deep Purple base
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        bodyMedium: GoogleFonts.inter(
          textStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.w300),
        ),
        bodyLarge: GoogleFonts.inter(
          textStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, fontWeight: FontWeight.w400),
        ),
        titleLarge: GoogleFonts.outfit(
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        displayMedium: GoogleFonts.outfit(
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.02),
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.06), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: quantumViolet,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white.withOpacity(0.12), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}
