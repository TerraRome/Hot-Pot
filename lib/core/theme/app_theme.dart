import 'package:flutter/material.dart';
import 'package:hot_pot/core/theme/app_colors.dart';

/// Light dan dark theme — Crimson Dragon Hot Pot design system v2.4.0
abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.primaryText,
          primaryContainer: AppColors.primaryBg,
          onPrimaryContainer: AppColors.primary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.secondaryText,
          secondaryContainer: AppColors.secondaryBg,
          onSecondaryContainer: AppColors.secondaryText,
          error: AppColors.danger,
          onError: Colors.white,
          surface: AppColors.surface,
          onSurface: AppColors.foreground,
          onSurfaceVariant: AppColors.textSecondary,
          outline: AppColors.border,
          outlineVariant: AppColors.borderDivider,
        ),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.borderDivider),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primaryBg,
          labelStyle: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.borderDivider,
          thickness: 1,
          space: 0,
        ),
        textTheme: _textTheme(AppColors.foreground),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryHover,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primaryMuted,
          onPrimaryContainer: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: AppColors.secondaryText,
          secondaryContainer: AppColors.secondaryBg,
          onSecondaryContainer: AppColors.secondary,
          error: AppColors.danger,
          onError: Colors.white,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.foregroundDark,
          onSurfaceVariant: AppColors.textSecondaryDark,
          outline: AppColors.borderDividerDark,
          outlineVariant: AppColors.borderDividerDark,
        ),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: AppColors.foregroundDark,
          elevation: 0,
          centerTitle: false,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.borderDividerDark),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceDark,
          selectedItemColor: AppColors.primaryHover,
          unselectedItemColor: AppColors.textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.borderDividerDark,
          thickness: 1,
          space: 0,
        ),
        textTheme: _textTheme(AppColors.foregroundDark),
      );

  static TextTheme _textTheme(Color color) => TextTheme(
        // display
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        // headline
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        // title
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        // body
        bodyLarge: TextStyle(fontSize: 16, color: color, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: color, height: 1.5),
        bodySmall: TextStyle(fontSize: 12, color: color, height: 1.4),
        // label
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      );
}
