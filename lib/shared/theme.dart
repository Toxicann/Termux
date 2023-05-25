import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KThemes {
  static final primaryTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xfff6f6f6),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: const Color(0xffff8e6e),
      backgroundColor: const Color(0xff515070),
    ),
    highlightColor: const Color(0xffffbb91),
    textTheme: TextTheme(
      bodyMedium: GoogleFonts.sourceCodePro(
        fontWeight: FontWeight.w500,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xfff6f6f6),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      
    ),
  );
}
