import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';

class _Review {
  final String author;
  final double rating;
  final String date;
  final String text;

  const _Review(this.author, this.rating, this.date, this.text);
}

class LawyerReviewsScreen extends StatelessWidget {
  const LawyerReviewsScreen({super.key});

  final List<_Review> _reviews = const [
    _Review('Hassan Ali', 5.0, '2 days ago', 'Excellent advocate! Handled my property dispute very professionally and kept me updated throughout the process. Highly recommend.'),
    _Review('Fatima Khan', 4.5, '1 week ago', 'Very knowledgeable and transparent about fees. The initial consultation was very helpful in understanding my options.'),
    _Review('Usman Tariq', 5.0, '3 weeks ago', 'Secured a favorable outcome in my case. Worth every penny.'),
    _Review('Zainab Malik', 4.0, '1 month ago', 'Good experience overall. Sometimes hard to reach due to busy schedule, but gets the work done.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Client Reviews', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Overall Rating
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.kBgSurface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.kBorder),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('4.9', style: GoogleFonts.plusJakartaSans(fontSize: 48, fontWeight: FontWeight.w800, color: AppColors.kTextPrimary)),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) => Icon(Icons.star_rounded, color: index == 4 ? AppColors.kTextTertiary : AppColors.kGold, size: 16)),
                      ),
                      const SizedBox(height: 8),
                      Text('124 Reviews', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      children: [
                        _ratingBar(5, 0.8),
                        _ratingBar(4, 0.15),
                        _ratingBar(3, 0.05),
                        _ratingBar(2, 0.0),
                        _ratingBar(1, 0.0),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1),
            const SizedBox(height: 32),
            
            ..._reviews.asMap().entries.map((e) {
              final i = e.key;
              final r = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.kBgSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.kBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(r.author, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                        Text(r.date, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(5, (index) => Icon(Icons.star_rounded, color: index < r.rating.toInt() ? AppColors.kGold : AppColors.kTextTertiary, size: 14)),
                    ),
                    const SizedBox(height: 12),
                    Text(r.text, style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.kTextSecondary, height: 1.5)),
                  ],
                ),
              ).animate(delay: (100 + i * 50).ms).fadeIn().slideY(begin: 0.1);
            }),
          ],
        ),
      ),
    );
  }

  Widget _ratingBar(int star, double pct) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$star', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.kTextSecondary)),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: pct,
                backgroundColor: AppColors.kBgElevated,
                valueColor: const AlwaysStoppedAnimation(AppColors.kGold),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
