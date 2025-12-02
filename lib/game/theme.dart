import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberpunkTheme {
  static const Color background = Color(0xFF000000);
  static const Color gridLine = Color(0xFF0F1F0F);
  static const Color neonGreen = Color(0xFF00FF00);
  static const Color neonGreenDim = Color(0xFF008800);
  static const Color neonGreenBright = Color(0xFFCCFFCC);
  static const Color neonPink = Color(0xFFFF00FF);
  static const Color glassBackground = Color(
    0x1A00FF00,
  ); // rgba(0, 255, 0, 0.1)
  static const Color glassBorder = Color(0x4D00FF00); // rgba(0, 255, 0, 0.3)
  static const Color textGray = Color(0xFF9CA3AF); // gray-400
  static const Color errorRed = Color(0xFFEF4444); // red-500

  static TextStyle get pressStart2P => GoogleFonts.pressStart2p();

  static TextStyle get hudScoreLabel =>
      pressStart2P.copyWith(fontSize: 10, color: textGray);

  static TextStyle get hudScoreValue => pressStart2P.copyWith(
    fontSize: 20,
    color: neonGreen,
    shadows: [
      const Shadow(blurRadius: 5, color: neonGreen),
      const Shadow(blurRadius: 10, color: neonGreen),
    ],
  );

  static TextStyle get titleStyle => pressStart2P.copyWith(
    fontSize: 32,
    color: Colors.transparent,
    shadows: [const Shadow(blurRadius: 10, color: neonGreen)],
    // Note: Gradient text needs a ShaderMask in Flutter usually,
    // but we can simulate the look or use a simple color for now
    // and enhance with ShaderMask in the widget tree.
  );
}
