import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/auth/presentation/providers/reset_password.dart';
import 'package:lex_core/features/auth/presentation/states/reset_password_state.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final password = _passwordController.text.trim();

      try {
        final response = await ref.read(resetPasswordProvider.notifier).resetPassword(password);
        if (response.isNotEmpty) {
          log("ResetPasswordScreen -> ResetPassword response: $response");
          if (mounted) {
            _showSuccessDialog();
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password update failed.'), backgroundColor: AppColors.kError),
            );
          }
        }
      } catch (e, st) {
        log("ResetPasswordScreen -> Exception: $e\n$st");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occurred.'), backgroundColor: AppColors.kError),
          );
        }
      }
    }
  }

  void _showSuccessDialog() {
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
            Text('Success!', style: AppTypography.h2),
            const SizedBox(height: 8),
            Text('Your password has been successfully reset. You can now log in with your new password.',
                textAlign: TextAlign.center,
                style: AppTypography.body),
            const SizedBox(height: 24),
            LexButton(
              label: 'Back to Login',
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(resetPasswordProvider) is ResetPasswordStateLoading;

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgDeep,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.kBrand.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.kBrand.withValues(alpha: 0.3)),
                  ),
                  child: const Icon(Icons.password_rounded, color: AppColors.kBrand, size: 32),
                ).animate().scaleXY(curve: Curves.easeOutBack, duration: 600.ms),
                const SizedBox(height: 32),
                
                Text('New Password', style: AppTypography.h1)
                    .animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 8),
                Text('Create a new, strong password for your account.', style: AppTypography.body)
                    .animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 48),

                LexTextField(
                  controller: _passwordController,
                  hintText: 'New Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  validator: AppValidation.checkText,
                  suffixWidget: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.kTextSecondary, size: 20),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                
                const SizedBox(height: 16),

                LexTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_rounded,
                  obscureText: _obscureConfirmPassword,
                  validator: (val) => AppValidation.validateConfirmPassword(_passwordController.text, val),
                  suffixWidget: IconButton(
                    icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.kTextSecondary, size: 20),
                    onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                  ),
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),

                const SizedBox(height: 48),

                LexButton(
                  label: 'Reset Password',
                  style: LexButtonStyle.primary,
                  fullWidth: true,
                  isLoading: isLoading,
                  onPressed: _resetPassword,
                ).animate(delay: 500.ms).fadeIn().slideY(begin: 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
