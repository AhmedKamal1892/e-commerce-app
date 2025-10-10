import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF1E1E1E);
  static const Color foreground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFF232323);
  static const Color surface2 = Color(0xFF2A2A2A);
  static const Color card = Color(0xFF232323);
  static const Color cardForeground = Color(0xFFFFFFFF);
  static const Color popover = Color(0xFF232323);
  static const Color popoverForeground = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFFFFFFF);
  static const Color primaryForeground = Color(0xFF1E1E1E);
  static const Color secondary = Color(0xFFB3B3B3);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFF2A2A2A);
  static const Color mutedForeground = Color(0xFFB3B3B3);
  static const Color accent = Color(0xFFF24822);
  static const Color accentForeground = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF22C55E);
  static const Color successForeground = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningForeground = Color(0xFFFFFFFF);
  static const Color destructive = Color(0xFFF24822);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0xFF2A2A2A);
  static const Color input = Color(0xFF2A2A2A);
  static const Color inputBackground = Color(0xFF2A2A2A);
  static const Color switchBackground = Color(0xFF2A2A2A);
  static const Color ring = Color(0xFFF24822);

  static const Color chart1 = Color(0xFFF24822);
  static const Color chart2 = Color(0xFF22C55E);
  static const Color chart3 = Color(0xFFF59E0B);
  static const Color chart4 = Color(0xFFB3B3B3);
  static const Color chart5 = Color(0xFFFFFFFF);

  static const Color sidebar = Color(0xFF232323);
  static const Color sidebarForeground = Color(0xFFFFFFFF);
  static const Color sidebarPrimary = Color(0xFFF24822);
  static const Color sidebarPrimaryForeground = Color(0xFFFFFFFF);
  static const Color sidebarAccent = Color(0xFF2A2A2A);
  static const Color sidebarAccentForeground = Color(0xFFFFFFFF);
  static const Color sidebarBorder = Color(0xFF2A2A2A);
  static const Color sidebarRing = Color(0xFFF24822);
}

class AppConstants {
  static const double borderRadius = 12.0;
  static const double paddingS = 4.0;
  static const double paddingM = 8.0;
  static const double paddingL = 12.0;
  static const double paddingXL = 16.0;
  static const double paddingXXL = 24.0;

  static const FontWeight fontWeightNormal = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      hintColor: AppColors.mutedForeground,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.card,
      dividerColor: AppColors.border,
      canvasColor: AppColors.sidebar,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.foreground,
        elevation: 0,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.foreground,
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.foreground,
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.foreground,
        ),
        headlineMedium: TextStyle(
          fontSize: 16,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.foreground,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.foreground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: AppConstants.fontWeightNormal,
          color: AppColors.foreground,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: AppConstants.fontWeightNormal,
          color: AppColors.mutedForeground,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: AppConstants.fontWeightMedium,
          color: AppColors.primaryForeground,
        ),
      ),

      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.accent,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.accentForeground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          textStyle: const TextStyle(fontWeight: AppConstants.fontWeightMedium),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingXL,
            vertical: AppConstants.paddingL,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(fontWeight: AppConstants.fontWeightMedium),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        labelStyle: const TextStyle(color: AppColors.mutedForeground),
        hintStyle: const TextStyle(color: AppColors.mutedForeground),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.ring, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.destructive, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: AppColors.destructive, width: 2),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
