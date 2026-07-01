import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/core/validation/app_validation.dart';
import 'package:lex_core/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:lex_core/features/auth/presentation/states/forogot_password_State.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _forgotPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      try {
        final response = await ref.read(forgotPasswordProvider.notifier).forgotPassword(email: email);
        if (response.isEmpty) {
          log("ForgotPasswordScreen -> ForgotPassword response: $response");
          await StorageService.instance.write(AppKeys.forgotEmailKey, email);
          context.pushNamed(RouteNames.otpScreen);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response), backgroundColor: AppColors.kError),
          );
        }
      } catch (e, st) {
        log("ForgotPasswordScreen -> Exception: $e\n$st");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to process request.'), backgroundColor: AppColors.kError),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(forgotPasswordProvider) is ForgotPasswordLoading;

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
                  child: const Icon(Icons.lock_reset_rounded, color: AppColors.kBrand, size: 32),
                ).animate().scaleXY(curve: Curves.easeOutBack, duration: 600.ms),
                const SizedBox(height: 32),
                
                Text('Reset Password', style: AppTypography.h1)
                    .animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 8),
                Text('Enter your email to receive a password reset code.', style: AppTypography.body)
                    .animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 48),

                LexTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  prefixIcon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidation.validateEmail,
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                
                const SizedBox(height: 48),

                LexButton(
                  label: 'Send Code',
                  style: LexButtonStyle.primary,
                  fullWidth: true,
                  isLoading: isLoading,
                  onPressed: _forgotPassword,
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
