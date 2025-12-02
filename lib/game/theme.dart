import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum GameTheme { neonGreen, synthwave, oceanBlue, fireRed }

class GameThemeData {
  final String name;
  final Color primary;
  final Color primaryDim;
  final Color primaryBright;
  final Color secondary;
  final Color gridLine;
  final Color glassBackground;
  final Color glassBorder;
  final List<Color> titleGradient;

  const GameThemeData({
    required this.name,
    required this.primary,
    required this.primaryDim,
    required this.primaryBright,
    required this.secondary,
    required this.gridLine,
    required this.glassBackground,
    required this.glassBorder,
    required this.titleGradient,
  });

  static const neonGreen = GameThemeData(
    name: 'NEON GREEN',
    primary: Color(0xFF00FF00),
    primaryDim: Color(0xFF008800),
    primaryBright: Color(0xFFCCFFCC),
    secondary: Color(0xFFFF00FF),
    gridLine: Color(0xFF0F1F0F),
    glassBackground: Color(0x1A00FF00),
    glassBorder: Color(0x4D00FF00),
    titleGradient: [Color(0xFF4ADE80), Color(0xFF166534)],
  );

  static const synthwave = GameThemeData(
    name: 'SYNTHWAVE',
    primary: Color(0xFFFF00FF), // Magenta
    primaryDim: Color(0xFF8800AA),
    primaryBright: Color(0xFFFFCCFF),
    secondary: Color(0xFF00FFFF), // Cyan
    gridLine: Color(0xFF1F0F1F),
    glassBackground: Color(0x1AFF00FF),
    glassBorder: Color(0x4DFF00FF),
    titleGradient: [Color(0xFFE879F9), Color(0xFF581C87)],
  );

  static const oceanBlue = GameThemeData(
    name: 'OCEAN BLUE',
    primary: Color(0xFF00CCFF), // Bright Cyan
    primaryDim: Color(0xFF0066AA),
    primaryBright: Color(0xFFCCF0FF),
    secondary: Color(0xFFFFAA00), // Orange
    gridLine: Color(0xFF0F1F2F),
    glassBackground: Color(0x1A00CCFF),
    glassBorder: Color(0x4D00CCFF),
    titleGradient: [Color(0xFF38BDF8), Color(0xFF075985)],
  );

  static const fireRed = GameThemeData(
    name: 'FIRE RED',
    primary: Color(0xFFFF3300), // Red-Orange
    primaryDim: Color(0xFFAA1100),
    primaryBright: Color(0xFFFFCC99),
    secondary: Color(0xFFFFDD00), // Yellow
    gridLine: Color(0xFF2F0F0F),
    glassBackground: Color(0x1AFF3300),
    glassBorder: Color(0x4DFF3300),
    titleGradient: [Color(0xFFF97316), Color(0xFF7C2D12)],
  );

  static GameThemeData fromEnum(GameTheme theme) {
    switch (theme) {
      case GameTheme.neonGreen:
        return neonGreen;
      case GameTheme.synthwave:
        return synthwave;
      case GameTheme.oceanBlue:
        return oceanBlue;
      case GameTheme.fireRed:
        return fireRed;
    }
  }
}

class CyberpunkTheme {
  static GameThemeData _currentTheme = GameThemeData.neonGreen;

  static GameThemeData get current => _currentTheme;

  static void setTheme(GameTheme theme) {
    _currentTheme = GameThemeData.fromEnum(theme);
  }

  static const Color background = Color(0xFF000000);
  static const Color textGray = Color(0xFF9CA3AF);
  static const Color errorRed = Color(0xFFEF4444);

  // Theme-dependent colors
  static Color get primary => _currentTheme.primary;
  static Color get primaryDim => _currentTheme.primaryDim;
  static Color get primaryBright => _currentTheme.primaryBright;
  static Color get secondary => _currentTheme.secondary;
  static Color get gridLine => _currentTheme.gridLine;
  static Color get glassBackground => _currentTheme.glassBackground;
  static Color get glassBorder => _currentTheme.glassBorder;

  // Legacy accessors for backward compatibility
  static Color get neonGreen => primary;
  static Color get neonGreenDim => primaryDim;
  static Color get neonGreenBright => primaryBright;
  static Color get neonPink => secondary;

  static TextStyle get pressStart2P => GoogleFonts.pressStart2p();

  static TextStyle get hudScoreLabel =>
      pressStart2P.copyWith(fontSize: 10, color: textGray);

  static TextStyle get hudScoreValue => pressStart2P.copyWith(
    fontSize: 20,
    color: primary,
    shadows: [
      Shadow(blurRadius: 5, color: primary),
      Shadow(blurRadius: 10, color: primary),
    ],
  );

  static TextStyle get titleStyle => pressStart2P.copyWith(
    fontSize: 32,
    color: Colors.transparent,
    shadows: [Shadow(blurRadius: 10, color: primary)],
  );
}
