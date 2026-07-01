import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/database/hive_service.dart';

class CertificateViewerScreen extends StatelessWidget {
  const CertificateViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = HiveService.getUserName() ?? 'Student Name';

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Certificate', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.download_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Certificate Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.kBgSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.kBorder, width: 8),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Lex', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
                        Text('Core', style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.kBrand)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('LEGAL EDUCATION INSTITUTE', style: GoogleFonts.plusJakartaSans(fontSize: 10, letterSpacing: 3, color: AppColors.kTextSecondary)),
                    
                    const SizedBox(height: 48),
                    Text('CERTIFICATE OF COMPLETION', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kGold, letterSpacing: 2)),
                    const SizedBox(height: 24),
                    Text('This is to certify that', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary)),
                    const SizedBox(height: 16),
                    Text(name, style: GoogleFonts.greatVibes(fontSize: 48, color: AppColors.kTextPrimary)),
                    const SizedBox(height: 16),
                    Text('has successfully completed the specialization course', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary)),
                    const SizedBox(height: 16),
                    Text('FAMILY LAW & CUSTODY RIGHTS', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary, letterSpacing: 1)),
                    
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text('Jun 15, 2026', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.kTextPrimary)),
                            Container(width: 80, height: 1, color: AppColors.kBorder, margin: const EdgeInsets.symmetric(vertical: 4)),
                            Text('DATE', style: GoogleFonts.plusJakartaSans(fontSize: 9, color: AppColors.kTextTertiary, letterSpacing: 1)),
                          ],
                        ),
                        Container(
                          width: 60, height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.kGold, width: 2),
                          ),
                          child: Center(
                            child: Icon(Icons.workspace_premium_rounded, color: AppColors.kGold, size: 32),
                          ),
                        ),
                        Column(
                          children: [
                            Text('Adv. Raza Khan', style: GoogleFonts.dancingScript(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                            Container(width: 80, height: 1, color: AppColors.kBorder, margin: const EdgeInsets.symmetric(vertical: 4)),
                            Text('DIRECTOR', style: GoogleFonts.plusJakartaSans(fontSize: 9, color: AppColors.kTextTertiary, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.9, curve: Curves.easeOutBack),
              
              const SizedBox(height: 40),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.kBgSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.kBorder),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, color: AppColors.kSuccess, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Credential Verified', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                          Text('Credential ID: LXI-2026-FML-9042', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 400.ms).fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
