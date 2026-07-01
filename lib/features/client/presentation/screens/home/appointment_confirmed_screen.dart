import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';

class AppointmentConfirmedScreen extends StatelessWidget {
  const AppointmentConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  gradient: AppColors.kSuccessGradient,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: AppColors.kSuccess.withOpacity(0.3), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 64),
              ).animate().scaleXY(curve: Curves.elasticOut, duration: 800.ms),
              const SizedBox(height: 32),
              
              Text('Appointment Confirmed',
                  style: GoogleFonts.plusJakartaSans(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Text('Your consultation with Adv. Raza Khan has been booked successfully.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.kTextSecondary)).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 48),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.kBgSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.kBorder),
                ),
                child: Column(
                  children: [
                    _infoRow('Date & Time', 'Oct 24, 2026 at 10:00 AM'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(color: AppColors.kBorder, height: 1)),
                    _infoRow('Mode', 'Video Call'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(color: AppColors.kBorder, height: 1)),
                    _infoRow('Fee Paid', 'Rs. 15,000'),
                  ],
                ),
              ).animate(delay: 600.ms).fadeIn().slideY(begin: 0.1),
              
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: LexButton(
                  label: 'Back to Dashboard',
                  style: LexButtonStyle.primary,
                  onPressed: () => context.go(RouteNames.bottomNavigationScreen),
                ),
              ).animate(delay: 800.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
        Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
      ],
    );
  }
}
