import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:sizer/sizer.dart';

class SearchLawyerWidget extends StatelessWidget {
  const SearchLawyerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image with blur and soft white overlay
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/search_lawyer_bg.jpg',
                  fit: BoxFit.cover,
                ),
                Container(color: Colors.white.withValues(alpha: 0.15)), // Let more of the image show through
              ],
            ),
          ),
        ),
        
        // Gradient overlay from mid-height to blend into bottom
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.8),
                  Colors.white,
                ],
                stops: const [0.0, 0.45, 0.65, 1.0], // Starts fading much lower
              ),
            ),
          ),
        ),
        
        // Content
        Positioned.fill(
          child: Column(
            children: [
              const Spacer(flex: 6), // Pushes the content into the bottom half
              
              // Simple blue scales-of-justice icon
              const Icon(
                Icons.balance_rounded,
                size: 72,
                color: AppColors.kBrand,
              ),
              
              SizedBox(height: 2.5.h),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  children: [
                    Text(
                      'Find The Best Lawyers',
                      style: AppTypography.h1,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Search for highly rated professionals, explore their practice areas, and read detailed case histories.',
                      style: AppTypography.body,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              const Spacer(flex: 3), // Leaves room for the indicators and next button
            ],
          ),
        ),
      ],
    );
  }
}
