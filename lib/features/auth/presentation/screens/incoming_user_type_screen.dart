import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/database/hive_service.dart';

class IncomingUserTypeScreen extends StatelessWidget {
  const IncomingUserTypeScreen({super.key});

  void _selectRole(BuildContext context, String role) async {
    // Save intended role so login/signup knows what to do
    await HiveService.saveSetting(HiveService.kUserRole, role);
    if (!context.mounted) return;
    context.push(RouteNames.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Top Image with Fade
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/role_selection_bg.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white,
                        ],
                        stops: const [0.0, 0.6, 0.85, 1.0],
                      ),
                    ),
                  ),
                ),
                
                // Floating Blue Scale Icon
                Positioned(
                  left: 32,
                  bottom: -10, // Positioned overlapping the edge
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E63F6), // The bright blue from reference
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E63F6).withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.balance_rounded, color: Colors.white, size: 32),
                  ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.8, 0.8)),
                ),
              ],
            ),
            
            // Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Choose your role',
                    style: AppTypography.h1.copyWith(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A), // Dark navy
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Select how you want to use LexCore\nto get a tailored experience.',
                    style: AppTypography.body.copyWith(
                      fontSize: 16,
                      color: const Color(0xFF64748B), // Slate grey
                      height: 1.5,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.1),
                  
                  const SizedBox(height: 40),

                  // Cards Section
                  _buildRoleCard(
                    context,
                    title: 'Client',
                    subtitle: 'Find a lawyer, book\nappointments, and\nmanage your legal\nmatters.',
                    icon: Icons.person_outline_rounded,
                    color: const Color(0xFF3B82F6), // Blue
                    role: 'client',
                    delay: 200,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildRoleCard(
                    context,
                    title: 'Lawyer',
                    subtitle: 'Manage clients,\nschedule consultations,\nand grow your practice.',
                    icon: Icons.gavel_rounded,
                    color: const Color(0xFFD9A05B), // Muted Gold/Yellow
                    role: 'lawyer',
                    delay: 300,
                  ),
                  const SizedBox(height: 20),
                  
                  _buildRoleCard(
                    context,
                    title: 'Law Student',
                    subtitle: 'Access legal resources,\nresearch materials, and\ninternships.',
                    icon: Icons.school_outlined,
                    color: const Color(0xFF8B5CF6), // Purple
                    role: 'student',
                    delay: 400,
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required String role,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        // Extremely subtle border tinted with the brand color
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _selectRole(context, role),
          borderRadius: BorderRadius.circular(24),
          splashColor: color.withValues(alpha: 0.1),
          highlightColor: color.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon Squircle
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(icon, color: color, size: 30),
                ),
                const SizedBox(width: 20),
                
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title, 
                        style: AppTypography.h3.copyWith(
                          color: const Color(0xFF0F172A),
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle, 
                        style: AppTypography.caption.copyWith(
                          color: const Color(0xFF64748B),
                          height: 1.4,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Arrow Circle
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded, 
                    color: color, 
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate(delay: delay.ms).fadeIn(duration: 500.ms).slideY(begin: 0.1),
    );
  }
}
