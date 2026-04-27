import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary gradients
  static const Color bgDeep = Color(0xFF0F0C29);
  static const Color bgMid = Color(0xFF302B63);
  static const Color bgSurface = Color(0xFF1A1A2E);

  // Accent colors
  static const Color purple = Color(0xFF7B2FF7);
  static const Color purpleLight = Color(0xFFA855F7);
  static const Color cyan = Color(0xFF00D4FF);
  static const Color coral = Color(0xFFE94560);
  static const Color amber = Color(0xFFF59E0B);
  static const Color green = Color(0xFF4ADE80);

  // Glass
  static const Color glass = Color(0x12FFFFFF);
  static const Color glassBorder = Color(0x26FFFFFF);
  static const Color glassBorderStrong = Color(0x40FFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0x8CFFFFFF);
  static const Color textHint = Color(0x55FFFFFF);

  // Card backgrounds
  static const Color cardPurple = Color(0xFF2D1B69);
  static const Color cardBlue = Color(0xFF0F3460);
  static const Color cardRed = Color(0xFF5C1A2E);
}

class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.bgDeep, AppColors.bgMid, Color(0xFF24243E)],
  );

  static const LinearGradient purple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.purple, AppColors.purpleLight],
  );

  static const LinearGradient purpleCyan = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.purpleLight, AppColors.cyan],
  );

  static const LinearGradient workoutPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A0A3E), AppColors.cardPurple],
  );

  static const LinearGradient workoutBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A1A2E), AppColors.cardBlue],
  );

  static const LinearGradient workoutRed = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E0A1A), AppColors.cardRed],
  );

  static const LinearGradient eliteGold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A0E00), Color(0xFF3D2200)],
  );
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgDeep,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.bgSurface,
        error: AppColors.coral,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w800),
          displayMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          headlineLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: AppColors.textPrimary),
          bodyMedium: TextStyle(color: AppColors.textMuted),
          bodySmall: TextStyle(color: AppColors.textHint),
          labelSmall: TextStyle(color: AppColors.textMuted, letterSpacing: 1.2),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}

class AppDimens {
  static const double radiusSm = 12.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 28.0;
  static const double radiusFull = 100.0;

  static const double paddingXs = 6.0;
  static const double paddingSm = 12.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 20.0;
  static const double paddingXl = 24.0;

  static const double navHeight = 70.0;
}
