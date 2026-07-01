import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class LawyerSubscriptionScreen extends StatefulWidget {
  const LawyerSubscriptionScreen({super.key});

  @override
  State<LawyerSubscriptionScreen> createState() => _LawyerSubscriptionScreenState();
}

class _LawyerSubscriptionScreenState extends State<LawyerSubscriptionScreen> {
  bool _isAnnual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Upgrade Plan', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Text('Upgrade to LexCore Pro',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
            const SizedBox(height: 8),
            Text('Unlock the full power of your legal practice',
                style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.kTextSecondary),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),

            // Annual toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.kBgSurface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Row(
                children: [
                  _toggleBtn('Monthly', !_isAnnual, () => setState(() => _isAnnual = false)),
                  _toggleBtn('Annual (Save 17%)', _isAnnual, () => setState(() => _isAnnual = true)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Free plan
            _planCard(
              name: 'Free',
              price: 'Rs. 0',
              period: '/month',
              features: [
                '5 active cases max',
                'Basic case management',
                'Chat with clients',
                'Standard support',
              ],
              isCurrent: true,
              isPro: false,
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 16),

            // Pro plan
            _planCard(
              name: 'Pro',
              price: _isAnnual ? 'Rs. 29,999' : 'Rs. 2,999',
              period: _isAnnual ? '/year' : '/month',
              features: [
                'Unlimited cases',
                'Advanced analytics & charts',
                'Video consultations',
                'Earnings dashboard',
                'Document management',
                'Priority support',
                'Client management',
                'Calendar & scheduling',
              ],
              isCurrent: false,
              isPro: true,
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Upgrade button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.kBrandGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: AppColors.kBrandGlow, blurRadius: 20, offset: const Offset(0, 8))],
                ),
                child: ElevatedButton(
                  onPressed: () => _showUpgradeDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text('Upgrade to Pro',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Cancel anytime. No hidden fees.',
                style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextTertiary)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _toggleBtn(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: active ? AppColors.kBrandGradient : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : AppColors.kTextSecondary,
                )),
          ),
        ),
      ),
    );
  }

  Widget _planCard({
    required String name,
    required String price,
    required String period,
    required List<String> features,
    required bool isCurrent,
    required bool isPro,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPro ? AppColors.kBrand : AppColors.kBorder,
          width: isPro ? 2 : 1,
        ),
        boxShadow: isPro
            ? [BoxShadow(color: AppColors.kBrandGlow, blurRadius: 16)]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
              if (isPro) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: AppColors.kBrandGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('POPULAR',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.8)),
                ),
              ],
              if (isCurrent) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.kTextSecondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('CURRENT',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.kTextSecondary, letterSpacing: 0.8)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(period,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.kBorder),
          const SizedBox(height: 12),
          ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        size: 18, color: isPro ? AppColors.kBrand : AppColors.kTextSecondary),
                    const SizedBox(width: 10),
                    Text(f,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13, color: AppColors.kTextPrimary, fontWeight: FontWeight.w400)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.kBgSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Confirm Upgrade',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
        content: Text(
          'Upgrade to LexCore Pro for ${_isAnnual ? "Rs. 29,999/year" : "Rs. 2,999/month"}?\n\nThis is a demo — no charges will be made.',
          style: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.plusJakartaSans(color: AppColors.kTextSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('🎉 Welcome to LexCore Pro!', style: GoogleFonts.plusJakartaSans()),
                  backgroundColor: AppColors.kSuccess,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kBrand),
            child: Text('Confirm', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
