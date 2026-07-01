import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:sizer/sizer.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final VoidCallback onGetStarted;
  final Color color;
  final String imageAsset;
  final bool isComingSoon;

  const RoleCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    required this.onGetStarted,
    required this.color,
    required this.imageAsset,
    this.isComingSoon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.kBgElevated,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Header Section
              Container(
                height: 16.h, // Slightly taller for a premium feel
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  // Gradient overlay to blend into the card and tint it
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        color.withValues(alpha: 0.3), // Top tint
                        color.withValues(alpha: 0.1),
                        AppColors.kBgElevated, // Blends perfectly into the content section
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.25), // Soft glow matching the role color
                            blurRadius: 24,
                            spreadRadius: 4,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08), // Subtle depth shadow
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: color, size: 36),
                    ),
                  ),
                ),
              ),
              
              // Content Section
              Padding(
                padding: EdgeInsets.all(3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.h2.copyWith(color: color),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      description,
                      style: AppTypography.bodySm,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    
                    isComingSoon
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.kBgSurface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: Text(
                              "Coming Soon",
                              style: AppTypography.button.copyWith(color: AppColors.kTextSecondary),
                            ),
                          )
                        : LexButton(
                            label: buttonText,
                            onPressed: onGetStarted,
                            style: LexButtonStyle.primary,
                            fullWidth: true,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
