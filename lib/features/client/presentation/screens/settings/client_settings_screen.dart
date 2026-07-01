import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';

class ClientSettingsScreen extends StatelessWidget {
  const ClientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = HiveService.getUserName() ?? 'James Carter';
    final email = 'james.carter@gmail.com';
    final dp = 'https://randomuser.me/api/portraits/men/55.jpg';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Settings",
          style: AppTypography.h1.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              width: 44,
              height: 44,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(name, email, dp),
            const SizedBox(height: 32),
            _buildSectionTitle("Account"),
            _buildSettingTile(Icons.person_outline_rounded, "Edit Profile", "Change your personal information"),
            _buildSettingTile(Icons.notifications_none_rounded, "Notifications", "Manage your alert preferences"),
            _buildSettingTile(Icons.lock_outline_rounded, "Security", "Password and biometric settings"),
            
            const SizedBox(height: 24),
            _buildSectionTitle("General"),
            _buildSettingTile(Icons.language_rounded, "Language", "English (United States)"),
            _buildSettingTile(Icons.dark_mode_outlined, "Theme", "Dark Mode"),
            
            const SizedBox(height: 24),
            _buildSectionTitle("Support"),
            _buildSettingTile(Icons.help_outline_rounded, "Help Center", "FAQs and contact support"),
            _buildSettingTile(Icons.info_outline_rounded, "About", "Version 1.0.0"),
            
            const SizedBox(height: 40),
            _buildLogoutButton(context),
            const SizedBox(height: 100), // spacing for bottom nav
          ],
        ),
      ),
      ),
      ],
      ),
    );
  }

  Widget _buildProfileSection(String name, String email, String dp) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
            ),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: dp.isNotEmpty && dp.startsWith('http') ? NetworkImage(dp) : null,
              child: dp.isEmpty ? const Icon(Icons.person_rounded, size: 32, color: Color(0xFF94A3B8)) : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.h3.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: AppTypography.caption.copyWith(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_rounded, color: Color(0xFF3B82F6), size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.caption.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: const Color(0xFF94A3B8),
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, color: const Color(0xFF475569), size: 22),
        ),
        title: Text(
          title,
          style: AppTypography.h3.copyWith(fontSize: 16, color: const Color(0xFF0F172A)),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.caption.copyWith(fontSize: 12, color: const Color(0xFF64748B)),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
        onTap: () {},
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Logout', style: AppTypography.h2.copyWith(color: const Color(0xFF0F172A))),
            content: Text('Are you sure you want to logout?', style: AppTypography.body.copyWith(color: const Color(0xFF475569))),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel', style: AppTypography.body.copyWith(color: const Color(0xFF64748B))),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Logout', style: AppTypography.body.copyWith(color: const Color(0xFFEF4444))),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await StorageService.instance.clearAllAuthData();
          await HiveService.clearAuth();
          if (context.mounted) {
            context.go(RouteNames.incomingUserScreen);
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          border: Border.all(color: const Color(0xFFFECACA)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
              const SizedBox(width: 8),
              Text(
                "Log Out",
                style: AppTypography.h3.copyWith(color: const Color(0xFFEF4444)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
