import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/features/student/data/models/student_model.dart';
import 'package:lex_core/features/student/presentation/widgets/student_portal_header.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  // Mock student data
  final StudentModel student = StudentModel(
    id: '1',
    fullName: 'Esha Farrukh',
    university: 'Punjab University Law College',
    studyYear: 'Final Year',
    currentProgram: 'LL.B (Hons)',
    email: 'esha.farrukh@example.com',
    profileImage: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Match the updated deep background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StudentPortalHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header Stats
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem("3", "Active Tasks"),
                        Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                        _buildStatItem("2", "Certifications"),
                        Container(width: 1, height: 40, color: const Color(0xFFE2E8F0)),
                        _buildStatItem("2", "Research"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Academic Information
                  _buildSectionCard(
                    "Academic Information",
                    Icons.school_rounded,
                    [
                      _buildInfoRow("University", student.university),
                      _buildInfoRow("Study Year", student.studyYear),
                      _buildInfoRow("Current Program", student.currentProgram),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Account Settings
                  _buildSectionCard(
                    "Account Settings",
                    Icons.settings_rounded,
                    [
                      _buildMenuRow("Edit Profile", Icons.edit_rounded, () => _showEditProfileDialog(context)),
                      _buildMenuRow("Change Password", Icons.lock_outline_rounded, () => _showChangePasswordDialog(context)),
                      _buildMenuRow("Notifications", Icons.notifications_none_rounded, () => _showNotificationsDialog(context)),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Support
                  _buildSectionCard(
                    "Support",
                    Icons.help_outline_rounded,
                    [
                      _buildMenuRow("Help Center", Icons.support_agent_rounded, () => _showHelpDialog(context)),
                      _buildMenuRow("About", Icons.info_outline_rounded, () => _showAboutDialog(context)),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showLogoutDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEF2F2),
                        foregroundColor: const Color(0xFFEF4444),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout_rounded, size: 22),
                          const SizedBox(width: 10),
                          const Text(
                            "Logout",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF3B82F6))),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: const Color(0xFF3B82F6), size: 22),
                ),
                const SizedBox(width: 16),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5)),
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xFFF1F5F9)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF64748B), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCBD5E1), size: 16),
          ],
        ),
      ),
    );
  }

  // Placeholder methods to satisfy compiler
  void _showEditProfileDialog(BuildContext context) {}
  void _showChangePasswordDialog(BuildContext context) {}
  void _showNotificationsDialog(BuildContext context) {}
  void _showHelpDialog(BuildContext context) {}
  void _showAboutDialog(BuildContext context) {}
  void _showLogoutDialog(BuildContext context) {}
}
