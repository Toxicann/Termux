import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/shared/colors.dart';

class KThemes {
  static final primaryTheme = ThemeData(
    useMaterial3: true,
    primaryColor: KColor.primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: KColor.accentColor,
      backgroundColor: KColor.backgroundColor,
    ),
    highlightColor: KColor.secondaryColor,
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.sourceCodePro(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        color: KColor.primaryColor,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: KColor.primaryColor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 0.0),
      isCollapsed: true,
    ),
  );
}
