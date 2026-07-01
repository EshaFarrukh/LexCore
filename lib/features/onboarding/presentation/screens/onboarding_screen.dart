import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'icon': Icons.balance_rounded,
      'title': 'Find Your Legal Expert',
      'subtitle': 'Connect with verified lawyers across Pakistan for criminal, civil, family, and property matters.',
    },
    {
      'icon': Icons.folder_open_rounded,
      'title': 'Track Every Case',
      'subtitle': 'Monitor your case progress, upcoming hearings, and legal documents all in one secure place.',
    },
    {
      'icon': Icons.psychology_rounded,
      'title': 'Get Legal Guidance',
      'subtitle': 'Ask legal questions, book consultations, and get expert advice whenever you need it from our AI.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() async {
    await HiveService.saveSetting(HiveService.kOnboardingComplete, true);
    if (!mounted) return;
    context.go(RouteNames.incomingUserScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.kBgDeep, AppColors.kBgSurface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextButton(
                    onPressed: _finishOnboarding,
                    child: Text('Skip',
                        style: GoogleFonts.plusJakartaSans(
                            color: AppColors.kTextSecondary, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),

              // Page View
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.kBrandGradient,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.kBrand.withOpacity(0.3),
                                    blurRadius: 40,
                                    spreadRadius: 10),
                              ],
                            ),
                            child: Icon(page['icon'] as IconData, size: 80, color: Colors.white),
                          ).animate().fadeIn(duration: 500.ms).scaleXY(begin: 0.8),
                          const SizedBox(height: 60),
                          Text(
                            page['title'] as String,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary),
                          ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1),
                          const SizedBox(height: 16),
                          Text(
                            page['subtitle'] as String,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 15, color: AppColors.kTextSecondary, height: 1.5),
                          ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom controls
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: _pages.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.kBrand,
                        dotColor: AppColors.kBorder,
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentIndex == _pages.length - 1) {
                          _finishOnboarding();
                        } else {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          gradient: AppColors.kBrandGradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
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
