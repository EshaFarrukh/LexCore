import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/features/auth/presentation/providers/login_provider.dart';
import 'package:lex_core/features/auth/presentation/states/login_state.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _routeUser() async {
    final role = await StorageService.instance.read(AppKeys.userTypeKey);
    if (!mounted) return;

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
    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next is LoginSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message), backgroundColor: AppColors.kSuccess),
        );
        _routeUser();
      } else if (next is LoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error), backgroundColor: AppColors.kError),
        );
      }
    });

    final loginState = ref.watch(loginProvider);

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12), // Pushes form down below the bright image part

                    // Just the icon, no circle!
                    const Icon(Icons.shield_rounded, color: AppColors.kBrand, size: 64)
                        .animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
                    const SizedBox(height: 16),

                    Text('Login your account', style: AppTypography.h1)
                        .animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 8),
                    Text('Sign in to Continue', style: AppTypography.body)
                        .animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 48),

                    // Form fields
                    LexTextField(
                      controller: emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val == null || val.isEmpty ? 'Please enter your email' : null,
                    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    LexTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      validator: (val) => val == null || val.isEmpty ? 'Please enter your password' : null,
                      suffixWidget: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.kTextSecondary, size: 20),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 16),

                    // Remember me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: false, // Placeholder
                                onChanged: (val) {},
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                activeColor: AppColors.kBrand,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('Remember me', style: AppTypography.bodySm),
                          ],
                        ),
                        TextButton(
                          onPressed: () => context.push(RouteNames.forgotPasswordScreen),
                          child: Text('Forgot Password?', style: AppTypography.button.copyWith(color: AppColors.kBrand)),
                        ),
                      ],
                    ).animate(delay: 500.ms).fadeIn(),
                    const SizedBox(height: 32),

                    LexButton(
                      label: 'Sign In',
                      style: LexButtonStyle.primary,
                      fullWidth: true,
                      isLoading: loginState is LoginLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ref.read(loginProvider.notifier).login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        }
                      },
                    ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.1),

                    const SizedBox(height: 40),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.kBorder, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Or log in with', style: AppTypography.caption),
                        ),
                        Expanded(child: Divider(color: AppColors.kBorder, thickness: 1)),
                      ],
                    ).animate(delay: 700.ms).fadeIn(),
                    
                    const SizedBox(height: 32),
                    
                    // Social Logins
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.kBgSurface,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/google_logo.svg', height: 24),
                                const SizedBox(width: 12),
                                Text('Google', style: AppTypography.button.copyWith(color: AppColors.kTextPrimary)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.kBgSurface,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: AppColors.kBorder),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.apple, size: 26, color: Colors.black),
                                const SizedBox(width: 12),
                                Text('Apple', style: AppTypography.button.copyWith(color: AppColors.kTextPrimary)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).animate(delay: 800.ms).fadeIn().slideY(begin: 0.1),

                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: AppTypography.bodySm),
                        GestureDetector(
                          onTap: () => context.push(RouteNames.signupScreen),
                          child: Text('Sign Up', style: AppTypography.button.copyWith(color: AppColors.kBrand)),
                        ),
                      ],
                    ).animate(delay: 900.ms).fadeIn(),
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
