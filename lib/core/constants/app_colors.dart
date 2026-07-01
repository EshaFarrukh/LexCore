import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // === Background Levels ===
  static const Color kBgDeep = Color(0xFFF5F7FA); // Soft cool gray for scaffold
  static const Color kBgSurface = Color(0xFFFFFFFF); // Pure white for cards
  static const Color kBgElevated = Color(0xFFFFFFFF); // Pure white
  static const Color kBgOverlay = Color(0x99000000); // Dark overlay

  // === Primary / Accent ===
  static const Color kBrand = Color(0xFF2E5BFF); // Premium Cobalt Blue
  static const Color kBrandLight = Color(0xFF6C8DFF); 
  static const Color kBrandDark = Color(0xFF1E3FBA); 
  static const Color kBrandGlow = Color(0x262E5BFF);

  // === Surface Inverted (The "Black Pill" look) ===
  static const Color kSurfaceInverted = Color(0xFF111418); // Deep charcoal
  static const Color kSurfaceInvertedLight = Color(0xFF23272D); 

  // === Secondary ===
  static const Color kSecondary = Color(0xFFE8EDFF); // Soft blue background for tags
  
  // === Legal Gold (kept for legacy but muted) ===
  static const Color kGold = Color(0xFFD4AF37); 
  static const Color kGoldLight = Color(0xFFFBEFA5); 
  static const Color kGoldDark = Color(0xFFB8860B); 
  static const Color kGoldMuted = Color(0xFF8B7330);

  // === Status Colors ===
  static const Color kSuccess = Color(0xFF10B981); 
  static const Color kSuccessDim = Color(0xFFE6F8F3); 
  static const Color kWarning = Color(0xFFF59E0B); 
  static const Color kError = Color(0xFFEF4444); 
  static const Color kInfo = Color(0xFF3B82F6); 

  // === Text ===
  static const Color kTextPrimary = Color(0xFF111827); // Almost black
  static const Color kTextSecondary = Color(0xFF6B7280); // Cool gray
  static const Color kTextTertiary = Color(0xFF9CA3AF); // Lighter gray
  static const Color kTextInverse = Color(0xFFFFFFFF); // White text on dark buttons

  // === Borders ===
  static const Color kBorder = Color(0xFFE5E7EB); // Very soft gray border
  static const Color kBorderBrand = Color(0xFF2E5BFF);
  static const Color kBorderGold = Color(0xFFD4AF37);

  // === Gradients ===
  static const LinearGradient kBrandGradient = LinearGradient(
    colors: [Color(0xFF6C8DFF), Color(0xFF2E5BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient kSuccessGradient = LinearGradient(
    colors: [Color(0xFF34D399), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // === Legacy aliases (to avoid breaking existing code initially) ===
  static const Color kBg = kBgDeep;
  static const Color kSurface = kBgSurface;
  static const Color kSurfaceElevated = kBgElevated;
  static const Color kEmerald = kBrand;
  static const Color kEmeraldDark = kBrandDark;
  static const Color kBgDark = kBgDeep; // Repurposed for light mode to avoid breaks
  static const Color kInputBg = Color(0xFFF3F4F6); // Light gray input
  static const Color kBorderSubtle = kBorder;
  static const Color kSilver = Color(0xFFD1D5DB);
  static const Color backgroundColor = kBgSurface;
  static const Color blackColor = kTextPrimary;
  static const Color whiteColor = kBgSurface;
  static const Color iconColor = kBrand;
  static const Color hintTextColor = kTextTertiary;
  static const Color inputBackgroundColor = Color(0xFFF3F4F6);
  static const Color lightDescriptionTextColor = kTextSecondary;
  static const Color caseTypeBackgroundColor = kSecondary;

  static const LinearGradient btnLnGradColor = kBrandGradient;
  static const LinearGradient buttonGradientColor = kBrandGradient;
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFFBEFA5), Color(0xFFD4AF37)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Color pastelYellowColor = Color(0xFFFBEFA5);
  static const Color lightYellowColor = Color(0xFFE5D571);
  static const Color yellowColor = Color(0xFFD4AF37);
  static const Color brightYellowColor = Color(0xFFEFC94C);
  static const Color darkYellowColor = Color(0xFF8B7330);
}
