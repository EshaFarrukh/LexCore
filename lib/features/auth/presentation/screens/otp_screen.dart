import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/constants/app_keys.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:lex_core/features/auth/presentation/providers/otp_provider.dart';
import 'package:lex_core/features/auth/presentation/states/otp_state.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:lex_core/shared/widgets/lex_text_field.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _pin = '';

  Future<void> _verifyOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_pin.length != 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter 6-digit OTP'), backgroundColor: AppColors.kError),
        );
        return;
      }
      try {
        final response = await ref.read(otpProvider.notifier).verifyOtp(_pin);
        if (response.isEmpty) {
          log("OTPScreen -> OTP response: $response");
          context.go(RouteNames.resetPasswordScreen);
        }
      } catch (e, st) {
        log("OTPScreen -> Exception during OTP: $e\n$st");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP or Verification Failed'), backgroundColor: AppColors.kError),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(otpProvider) is OtpStateLoading;

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
                  child: const Icon(Icons.security_rounded, color: AppColors.kBrand, size: 32),
                ).animate().scaleXY(curve: Curves.easeOutBack, duration: 600.ms),
                const SizedBox(height: 32),
                
                Text('Verification Code', style: AppTypography.h1)
                    .animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 8),
                Text('Enter the 6-digit code we sent to your email address.', style: AppTypography.body)
                    .animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 48),

                LexTextField(
                  controller: TextEditingController(text: _pin),
                  hintText: '• • • • • •',
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  onChanged: (val) => _pin = val,
                ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                
                const SizedBox(height: 48),

                LexButton(
                  label: 'Verify OTP',
                  style: LexButtonStyle.primary,
                  fullWidth: true,
                  isLoading: isLoading,
                  onPressed: _verifyOtp,
                ).animate(delay: 400.ms).fadeIn().slideY(begin: 0.1),

                const SizedBox(height: 48),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Didn't receive the code? ",
                      style: AppTypography.body,
                      children: [
                        TextSpan(
                          text: 'Resend',
                          style: AppTypography.button.copyWith(color: AppColors.kBrandLight),
                          recognizer: TapGestureRecognizer()..onTap = () async {
                            final email = await StorageService.instance.read(AppKeys.forgotEmailKey);
                            if (email != null) {
                              ref.read(forgotPasswordProvider.notifier).forgotPassword(email: email);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('OTP Resent!'), backgroundColor: AppColors.kSuccess),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ).animate(delay: 500.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
