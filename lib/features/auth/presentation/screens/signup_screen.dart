import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/auth/presentation/providers/signup_provider.dart';
import 'package:lex_core/features/auth/presentation/states/signup_state.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ref.listenManual<SignupState>(signupProvider, (prev, next) {
      if (next is SignupSuccess) {
        _showSuccessDialog(next.message);
      } else if (next is SignupFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error), backgroundColor: AppColors.kError),
        );
      }
    });
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.kBgSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.kSuccessGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ).animate().scaleXY(curve: Curves.elasticOut, duration: 600.ms),
            const SizedBox(height: 24),
            Text('Account Created', style: AppTypography.h2),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center, style: AppTypography.body),
            const SizedBox(height: 24),
            LexButton(
              label: 'Continue to Login',
              style: LexButtonStyle.primary,
              fullWidth: true,
              onPressed: () {
                Navigator.pop(context);
                context.go(RouteNames.loginScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signup() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final role = HiveService.getUserRole() ?? 'client';

    await ref.read(signupProvider.notifier).signup(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneNumberController.text.trim(),
          password: _passwordController.text.trim(),
          address: _addressController.text.trim(),
          userType: role,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(signupProvider) is SignupLoading;

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
                    stops: const [0.3, 0.8, 1.0], // Fade harder and faster into the background
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12), // Pushes form down below the bright image part
                    
                    // Just the icon, no circle!
                    const Icon(Icons.shield_rounded, color: AppColors.kBrand, size: 64)
                        .animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
                    const SizedBox(height: 16),

                    Text('Create an account', style: AppTypography.h1)
                        .animate().fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 8),
                    Text('Quick Sign-up, Instant Access', style: AppTypography.body)
                        .animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 40),

                    // Form Fields (styled with the existing premium LexTextField)
                    LexTextField(
                      controller: _nameController,
                      hintText: 'Full Name',
                      prefixIcon: Icons.person_outline,
                      validator: AppValidation.validateFullName,
                    ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    LexTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidation.validateEmail,
                    ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    LexTextField(
                      controller: _phoneNumberController,
                      hintText: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: AppValidation.validatePhoneNumber,
                    ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    LexTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      validator: AppValidation.checkText,
                      suffixWidget: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: AppColors.kTextSecondary, size: 20),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1),
                    const SizedBox(height: 16),
                    
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
                        Text('I agree to Terms & Conditions', style: AppTypography.bodySm),
                      ],
                    ).animate(delay: 600.ms).fadeIn(),
                    const SizedBox(height: 32),

                    LexButton(
                      label: 'Sign Up',
                      style: LexButtonStyle.primary,
                      fullWidth: true,
                      isLoading: isLoading,
                      onPressed: _signup,
                    ).animate(delay: 700.ms).fadeIn().slideY(begin: 0.1),
                    
                    const SizedBox(height: 32),
                    
                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: AppColors.kBorder, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('Or sign up with', style: AppTypography.caption),
                        ),
                        Expanded(child: Divider(color: AppColors.kBorder, thickness: 1)),
                      ],
                    ).animate(delay: 800.ms).fadeIn(),
                    
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
                                SvgPicture.asset('assets/images/google_logo.svg', width: 24, height: 24),
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
                    ).animate(delay: 900.ms).fadeIn().slideY(begin: 0.1),

                    const SizedBox(height: 40),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: AppTypography.bodySm,
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: AppTypography.button.copyWith(color: AppColors.kBrand),
                              recognizer: TapGestureRecognizer()..onTap = () => context.go(RouteNames.loginScreen),
                            ),
                          ],
                        ),
                      ),
                    ).animate(delay: 1000.ms).fadeIn(),
                    const SizedBox(height: 40),
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
