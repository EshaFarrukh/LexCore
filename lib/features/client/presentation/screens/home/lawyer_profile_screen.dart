import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';

class LawyerProfileScreen extends StatelessWidget {
  final String lawyerId;
  const LawyerProfileScreen({super.key, required this.lawyerId});

  @override
  Widget build(BuildContext context) {
    // Mock data for the profile
    final name = lawyerId == 'l2' ? 'Adv. Fatima Ahmed' : 'Adv. Raza Khan';
    final title = lawyerId == 'l2' ? 'Advocate High Court' : 'Senior Advocate High Court';
    final fee = lawyerId == 'l2' ? '10,000' : '15,000';

    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with image/header
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.kBgSurface,
            leading: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
                  ],
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.kTextPrimary, size: 20),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE2E8F0), Color(0xFFF8FAFC), AppColors.kBgDeep],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.kBrandLight.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: Center(
                          child: Text(name.substring(5, 6), style: AppTypography.display.copyWith(color: AppColors.kBrand)),
                        ),
                      ).animate().scaleXY(begin: 0.8, curve: Curves.easeOutBack, duration: 600.ms),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: AppTypography.h1),
                            const SizedBox(height: 4),
                            Text(title, style: AppTypography.body),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED), // Very soft orange/gold
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFFFEDD5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                            const SizedBox(width: 6),
                            Text('4.9', style: AppTypography.button.copyWith(color: const Color(0xFFD97706))),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 32),
                  
                  // Quick Stats
                  Row(
                    children: [
                      _statBox('Experience', '15 Years', Icons.military_tech_rounded),
                      const SizedBox(width: 16),
                      _statBox('Cases Won', '92%', Icons.emoji_events_rounded),
                      const SizedBox(width: 16),
                      _statBox('Reviews', '124', Icons.rate_review_rounded),
                    ],
                  ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 40),
                  
                  // About
                  Text('About', style: AppTypography.h2),
                  const SizedBox(height: 16),
                  Text('A highly experienced legal professional specializing in criminal and property law. Known for meticulous case preparation and a strong track record in High Court proceedings. Dedicated to providing transparent and strategic legal counsel.',
                      style: AppTypography.body.copyWith(height: 1.6)).animate(delay: 200.ms).fadeIn(),
                  const SizedBox(height: 40),
                  
                  // Specializations
                  Text('Specializations', style: AppTypography.h2),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12, runSpacing: 12,
                    children: ['Criminal Defense', 'Property Disputes', 'Constitutional Petitions', 'Civil Litigation'].map((s) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kBgSurface,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.kBorder),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
                      ),
                      child: Text(s, style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w600)),
                    )).toList(),
                  ).animate(delay: 300.ms).fadeIn(),
                  
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          border: const Border(top: BorderSide(color: AppColors.kBorder)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24, offset: const Offset(0, -8)),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consultation Fee', style: AppTypography.caption),
                const SizedBox(height: 4),
                Text('Rs. $fee', style: AppTypography.h2),
              ],
            ),
            const SizedBox(width: 32),
            Expanded(
              child: LexButton(
                label: 'Book Appointment',
                onPressed: () => context.push(RouteNames.appointmentBookingScreen, extra: lawyerId),
                style: LexButtonStyle.primary,
                fullWidth: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.kBgSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.kBorder),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.kBrandLight.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.kBrand, size: 24),
            ),
            const SizedBox(height: 12),
            Text(value, style: AppTypography.h3),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.caption),
          ],
        ),
      ),
    );
  }
}
