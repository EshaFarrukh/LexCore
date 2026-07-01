import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/features/onboarding/presentation/widgets/role_card.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class RoleOverviewScreen extends StatelessWidget {
  const RoleOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header Logo (Text based)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Lex',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary, letterSpacing: -1.0)),
                        Text('Core',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.kBrand, letterSpacing: -1.0)),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      title: "Smart Legal Connections for Pakistan",
                      fontSize: 14.sp,
                      color: AppColors.kTextSecondary,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      title: "Choose your role",
                      fontSize: 22.sp,
                      color: AppColors.kTextPrimary,
                      weight: FontWeight.w700,
                      letterSpacing: -0.5,
                      alignText: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      title: "Select how you want to use the platform.",
                      fontSize: 14.sp,
                      color: AppColors.kTextSecondary,
                    ),
                    SizedBox(height: 4.h),

                    // Role Cards
                    RoleCard(
                      title: "Legal Client",
                      description:
                          "Easily find and hire professional lawyers in Lahore. Track your cases and securely manage your legal journey.",
                      icon: Icons.person_search_rounded,
                      buttonText: "Get Started as Client \u2192",
                      onGetStarted: () => context.push(RouteNames.signupScreen),
                      color: AppColors.kBrand,
                      imageAsset: "assets/images/role_client_bg.jpg",
                    ),

                    RoleCard(
                      title: "Legal Professional",
                      description:
                          "Expand your practice, manage active court hearings, and connect with clients looking for your specific expertise.",
                      icon: Icons.balance_rounded,
                      buttonText: "Get Started as Lawyer \u2192",
                      onGetStarted: () =>
                          context.push(RouteNames.lawyerSignupScreen),
                      color: AppColors.kGold,
                      imageAsset: "assets/images/role_lawyer_bg.jpg",
                    ),
                    
                    RoleCard(
                      title: "Law Student",
                      description:
                          "Enroll in exclusive certification programs, access top-tier internships, and track your tasks to kickstart your career.",
                      icon: Icons.school_rounded,
                      buttonText: "Get Started as Student \u2192",
                      onGetStarted: () =>
                          context.push(RouteNames.studentSignupScreen),
                      color: AppColors.kSuccess,
                      imageAsset: "assets/images/role_student_bg.jpg",
                    ),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
