import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get display => GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.kTextPrimary,
        letterSpacing: -1.5,
        height: 1.1,
      );

  static TextStyle get h1 => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.kTextPrimary,
        letterSpacing: -1.0,
        height: 1.2,
      );

  static TextStyle get h2 => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.kTextPrimary,
        letterSpacing: -0.5,
        height: 1.3,
      );

  static TextStyle get h3 => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
        letterSpacing: -0.3,
        height: 1.4,
      );

  static TextStyle get h4 => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
        letterSpacing: -0.2,
        height: 1.4,
      );
      
  static TextStyle get h5 => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextPrimary,
        letterSpacing: -0.1,
        height: 1.5,
      );

  static TextStyle get body => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary, // In premium light mode, body is usually slightly softer than headings
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.kTextPrimary,
        height: 1.5,
      );

  static TextStyle get bodySm => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.kTextSecondary,
        height: 1.5,
      );

  static TextStyle get caption => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.kTextSecondary,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get label => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextSecondary,
        letterSpacing: 1.0,
      );

  static TextStyle get button => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextInverse,
        letterSpacing: 0.2,
      );

  static TextStyle get tabLabel => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.kTextSecondary,
      );

  // Colour variants
  static TextStyle get h1Brand => h1.copyWith(color: AppColors.kBrand);
  static TextStyle get h2Gold => h2.copyWith(color: AppColors.kGold);
  static TextStyle get bodySecondary => bodySm.copyWith(color: AppColors.kTextSecondary);
  static TextStyle get captionBrand => caption.copyWith(color: AppColors.kBrand);
  static TextStyle get captionSuccess => caption.copyWith(color: AppColors.kSuccess);
  static TextStyle get captionError => caption.copyWith(color: AppColors.kError);
  static TextStyle get captionWarning => caption.copyWith(color: AppColors.kWarning);
}
