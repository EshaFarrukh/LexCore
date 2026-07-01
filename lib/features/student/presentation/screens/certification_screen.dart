import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';

class _Course {
  final String id;
  final String title;
  final String instructor;
  final double progress;
  final int totalModules;
  final int completedModules;

  const _Course({
    required this.id, required this.title, required this.instructor,
    required this.progress, required this.totalModules, required this.completedModules,
  });
}

class CertificationScreen extends StatelessWidget {
  const CertificationScreen({super.key});

  static const List<_Course> _courses = [
    _Course(id: 'c1', title: 'Cybercrime & Digital Evidence', instructor: 'Adv. Raza Khan', progress: 0.33, totalModules: 12, completedModules: 4),
    _Course(id: 'c2', title: 'Family Law & Custody Rights', instructor: 'Adv. Fatima Ahmed', progress: 1.0, totalModules: 8, completedModules: 8),
    _Course(id: 'c3', title: 'Corporate Dispute Resolution', instructor: 'Adv. Hassan Ali', progress: 0.0, totalModules: 10, completedModules: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: AppColors.kBgSurface,
        title: Text('Certifications', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Earned Certificates section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Earned Certificates', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.kSuccess.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('1 Earned', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.kSuccess)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.push(RouteNames.certificateViewerScreen),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.kSuccess, Color(0xFF047857)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: AppColors.kSuccess.withOpacity(0.3), blurRadius: 16),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LL.B (Hons) Core Foundation', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('Completed on Jun 15, 2026', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.white70)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: Colors.white),
                  ],
                ),
              ),
            ).animate().fadeIn().slideX(begin: -0.1),
            const SizedBox(height: 32),

            // In Progress
            Text('In Progress', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 16),
            ..._courses.where((c) => c.progress > 0 && c.progress < 1.0).map((c) => _buildCourseCard(c)),
            
            const SizedBox(height: 32),

            // Available Courses
            Text('Available Courses', style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
            const SizedBox(height: 16),
            ..._courses.where((c) => c.progress == 0.0).map((c) => _buildCourseCard(c)),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(_Course c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.title, style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.kTextPrimary)),
                    const SizedBox(height: 4),
                    Text('Instructor: ${c.instructor}', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.kTextSecondary)),
                  ],
                ),
              ),
              if (c.progress == 0.0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.kBrand.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Enroll', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.kBrand)),
                ),
            ],
          ),
          if (c.progress > 0.0 && c.progress < 1.0) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${c.completedModules} / ${c.totalModules} Modules', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.kTextSecondary)),
                Text('${(c.progress * 100).toInt()}%', style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.kBrand)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: c.progress,
                backgroundColor: AppColors.kBorder,
                valueColor: const AlwaysStoppedAnimation(AppColors.kBrand),
                minHeight: 6,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}
