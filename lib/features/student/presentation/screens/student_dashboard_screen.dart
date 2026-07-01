import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/features/student/presentation/widgets/student_portal_header.dart';
import 'dart:ui';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slightly deeper cool grey for better contrast with white cards
      body: Column(
        children: [
          const StudentPortalHeader(),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Premium Certification Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.3), blurRadius: 24, offset: const Offset(0, 12)),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Icon(Icons.shield_rounded, size: 120, color: Colors.white.withOpacity(0.05)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                                    ),
                                    child: const Text('NEW MODULE',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1.0)),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('Cybercrime &\nDigital Evidence',
                                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2, letterSpacing: -0.5)),
                                  const SizedBox(height: 8),
                                  Text('Earn your LexCore specialisation certificate.',
                                      style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.7))),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: const Color(0xFF3B82F6).withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8)),
                                ],
                              ),
                              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate(delay: 100.ms).fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 24),

                  // Progress Stats
                  Row(
                    children: [
                      _statCard('Modules', '4/12', const Color(0xFFF0FDF4), const Color(0xFF22C55E), Icons.task_alt_rounded),
                      const SizedBox(width: 16),
                      _statCard('Research', '28h', const Color(0xFFEFF6FF), const Color(0xFF3B82F6), Icons.menu_book_rounded),
                    ],
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 32),

                  const Text('Quick Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
                  const SizedBox(height: 12),
                  
                  // Grid
                  GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.95,
                    children: [
                      _gridAction('Legal Research', 'Access 100k+ cases', Icons.library_books_rounded, const Color(0xFFEFF6FF), const Color(0xFF3B82F6)),
                      _gridAction('Mock Trials', 'Practice scenarios', Icons.gavel_rounded, const Color(0xFFFFF7ED), const Color(0xFFF97316)),
                      _gridAction('Certifications', 'View your progress', Icons.workspace_premium_rounded, const Color(0xFFF0FDF4), const Color(0xFF22C55E)),
                      _gridAction('AI Tutor', 'Ask legal questions', Icons.psychology_rounded, const Color(0xFFFEF2F2), const Color(0xFFEF4444)),
                    ],
                  ).animate(delay: 300.ms).fadeIn().slideY(begin: 0.1),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, Color bgColor, Color iconColor, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -1.0)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Widget _gridAction(String title, String subtitle, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
        ],
      ),
    );
  }
}
