import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_assets.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/student/presentation/providers/student_auth_provider/student_login_provider.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/features/student/presentation/states/student_auth_state/student_login_state.dart';
import 'package:lex_core/shared/widgets/custom_button.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:lex_core/shared/widgets/custom_text_field.dart';
import 'package:lex_core/shared/widgets/loading_indicator.dart';
import 'package:sizer/sizer.dart';

class StudentLoginScreen extends ConsumerStatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  ConsumerState<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends ConsumerState<StudentLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _studentLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final response = await ref
          .read(studentLoginProvider.notifier)
          .studentlLogin(email: email, password: password);
      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Login Successful"),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        // Navigate to Student Bottom Navigation screen after successful login
        context.go(RouteNames.studentBottomNavigationScreen);
      } else {
        _showErrorSnackBar("Invalid credentials");
      }
    } catch (e) {
      log("Login error: $e");
      _showErrorSnackBar("Something went wrong. Please try again.");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isloading = ref.watch(studentLoginProvider) is StudentLoginLoading;
    return Scaffold(
      backgroundColor: AppColors.kBgDeep, // Updated to match premium UI
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 18),
            ),
            onPressed: () => context.go(RouteNames.incomingUserScreen),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Beautiful Premium Header Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/signup_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.kBgDeep.withValues(alpha: 0.7),
                      AppColors.kBgDeep,
                    ],
                    stops: const [0.3, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // Scrollable Form Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                    // Icon instead of circle
                    const Icon(Icons.school_rounded, color: AppColors.kBrand, size: 64),
                    const SizedBox(height: 16),

                    CustomText(
                      title: "Welcome Student",
                      fontSize: 24.sp,
                      color: AppColors.kTextPrimary,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 0.8.h),
                    CustomText(
                      title: "Sign in to progress your education",
                      color: AppColors.kTextSecondary,
                      fontSize: 16.sp,
                    ),

                    SizedBox(height: 6.h),

                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email Address",
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: AppColors.kEmerald,
                        size: 22,
                      ),
                      validator: AppValidation.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textColor: AppColors.kTextPrimary,
                      hintTextColor: AppColors.kTextSecondary,
                    ),

                    SizedBox(height: 2.4.h),

                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: _obscurePassword,
                      validator: AppValidation.checkText,
                      textColor: AppColors.kTextPrimary,
                      hintTextColor: AppColors.kTextSecondary,
                      prefixIcon: Icon(
                        Icons.lock_rounded,
                        color: AppColors.kEmerald,
                        size: 22,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: AppColors.kEmerald.withOpacity(0.8),
                          size: 22,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),

                    SizedBox(height: 1.5.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push(RouteNames.forgotPasswordScreen),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppColors.kEmerald,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.5.h),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: isloading
                          ? const Center(
                              child: LoadingIndicator(color: AppColors.kEmerald),
                            )
                          : CustomButton(
                              text: "Sign in",
                              onPressed: _studentLogin,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.kEmerald,
                                  AppColors.kEmeraldDark,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              textColor: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              borderRadius: 16,
                            ),
                    ),

                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.kTextSecondary.withOpacity(0.2))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text("Or continue with", style: TextStyle(color: AppColors.kTextSecondary, fontSize: 13.sp)),
                        ),
                        Expanded(child: Divider(color: AppColors.kTextSecondary.withOpacity(0.2))),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Implement Google Sign In
                        },
                        icon: SvgPicture.asset('assets/images/google_logo.svg', height: 24),
                        label: Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: AppColors.kTextPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          side: BorderSide(color: AppColors.kTextSecondary.withOpacity(0.2)),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: AppColors.kTextSecondary,
                            fontSize: 15.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: AppColors.kEmerald,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () =>
                                    context.go(RouteNames.studentSignupScreen),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
