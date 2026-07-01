import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.kBgDeep,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.kBrand,
        secondary: AppColors.kGold,
        surface: AppColors.kBgSurface,
        error: AppColors.kError,
        onPrimary: AppColors.kTextPrimary,
        onSecondary: AppColors.kTextInverse,
        onSurface: AppColors.kTextPrimary,
        onError: AppColors.kTextPrimary,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.kTextPrimary,
        displayColor: AppColors.kTextPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kBgDeep,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.kTextPrimary,
        ),
        iconTheme: IconThemeData(color: AppColors.kTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.kBgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.kBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.kBgElevated,
        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kBrand, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kError),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kBrand,
          foregroundColor: AppColors.kTextPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 52),
          textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.kBrand,
          side: const BorderSide(color: AppColors.kBrand),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.kBgSurface,
        selectedItemColor: AppColors.kBrand,
        unselectedItemColor: AppColors.kTextSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.kBorder,
        thickness: 1,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.kBgElevated,
        contentTextStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.kBrand,
        unselectedLabelColor: AppColors.kTextSecondary,
        indicatorColor: AppColors.kBrand,
        dividerColor: AppColors.kBorder,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kBrand,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.kBrand,
        foregroundColor: AppColors.kTextPrimary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.kBgElevated,
        labelStyle: GoogleFonts.plusJakartaSans(color: AppColors.kTextPrimary, fontSize: 12),
        side: const BorderSide(color: AppColors.kBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      colorScheme: const ColorScheme.light(
        primary: AppColors.kBrand,
        secondary: AppColors.kGold,
        surface: Colors.white,
        error: AppColors.kError,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0D1117),
        ),
        iconTheme: IconThemeData(color: Color(0xFF0D1117)),
      ),
    );
  }
}
