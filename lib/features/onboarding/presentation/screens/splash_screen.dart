import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/core/constants/app_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  void _checkStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    final onboardingComplete = HiveService.getSetting<bool>(HiveService.kOnboardingComplete) ?? false;
    
    if (!onboardingComplete) {
      context.go(RouteNames.onboardingScreen);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      context.go(RouteNames.incomingUserScreen);
      return;
    }

    // Attempt to get role from SharedPreferences (StorageService)
    String? role = await StorageService.instance.read(AppKeys.userTypeKey);

    if (role == null || role.isEmpty) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          role = doc.data()?['role'] as String?;
          if (role != null && role.isNotEmpty) {
            await StorageService.instance.write(AppKeys.userTypeKey, role);
            await StorageService.instance.write(AppKeys.userIdKey, user.uid);
            await StorageService.instance.write(AppKeys.fullNameKey, doc.data()?['fullName'] ?? '');
            
            await HiveService.saveUserInfo(
              userId: user.uid,
              role: role,
              name: doc.data()?['fullName'] ?? '',
            );
          }
        }
      } catch (_) {}
    }

    if (!mounted) return;

    // Route based on role
    if (role == 'lawyer') {
      context.go(RouteNames.lawyerBottomNavigationScreen);
    } else if (role == 'student') {
      context.go(RouteNames.studentBottomNavigationScreen);
    } else {
      context.go(RouteNames.bottomNavigationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lex',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 48, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary, letterSpacing: -1.5)),
                  Text('Core',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 48, fontWeight: FontWeight.w800, color: AppColors.kBrand, letterSpacing: -1.5)),
                ],
              ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
            const SizedBox(height: 12),
            
            // Subtitle
            Text('Smart Global Legal Connections',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 14, color: AppColors.kTextSecondary, letterSpacing: 0.5, fontWeight: FontWeight.w500))
                .animate(delay: 400.ms)
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2),
            
            const SizedBox(height: 60),
            
            // Loading indicator
            SizedBox(
              width: 200,
              height: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.kBorder,
                  valueColor: const AlwaysStoppedAnimation(AppColors.kBrand),
                ),
              ),
            ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
