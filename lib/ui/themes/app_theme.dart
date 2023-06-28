import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tick_tac_toe_game/ui/themes/app_colors.dart';

class AppTheme {
  static final light = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: TextTheme(
      headlineSmall: GoogleFonts.coiny(),
      headlineMedium: GoogleFonts.coiny(
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.coiny(
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.coiny(
        color: AppColors.black,
      ),
      bodyMedium: GoogleFonts.coiny(
        color: AppColors.black,
      ),
      bodyLarge: GoogleFonts.coiny(
        color: AppColors.black,
      ),
    ),
  );
}
