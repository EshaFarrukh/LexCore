import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:lex_core/core/database/hive_service.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:sizer/sizer.dart';

class StudentSettingsScreen extends StatelessWidget {
  const StudentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBgDeep,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Settings",
          style: AppTypography.h2,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            SizedBox(height: 4.h),
            _buildSectionTitle("Academic"),
            _buildSettingTile(Icons.school_outlined, "Learning Progress", "Track your certification status"),
            _buildSettingTile(Icons.book_online_outlined, "Library", "Saved research and documents"),
            
            SizedBox(height: 3.h),
            _buildSectionTitle("Account"),
            _buildSettingTile(Icons.person_outline_rounded, "Edit Profile", "Change your personal information"),
            _buildSettingTile(Icons.notifications_none_rounded, "Notifications", "Manage your alert preferences"),
            
            SizedBox(height: 3.h),
            _buildSectionTitle("General"),
            _buildSettingTile(Icons.language_rounded, "Language", "English (United States)"),
            _buildSettingTile(Icons.dark_mode_outlined, "Theme", "Dark Mode"),
            
            SizedBox(height: 5.h),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.kGold.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 4.h,
            backgroundColor: AppColors.kGold.withValues(alpha: 0.2),
            child: Icon(Icons.school_rounded, size: 4.h, color: AppColors.kGold),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Esha Farrukh",
                  style: AppTypography.h3,
                ),
                Text(
                  "esha.farrukh@example.com",
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: AppColors.kGold),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, bottom: 1.5.h),
      child: Text(
        title,
        style: AppTypography.h3.copyWith(color: AppColors.kGold),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      decoration: BoxDecoration(
        color: AppColors.kBgSurface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.kTextPrimary),
        title: Text(
          title,
          style: AppTypography.body,
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.caption,
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.kTextSecondary),
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
            backgroundColor: AppColors.kBgSurface.withValues(alpha: 0.96),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Logout', style: AppTypography.h2),
            content: Text('Are you sure you want to logout?', style: AppTypography.body),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel', style: AppTypography.body.copyWith(color: AppColors.kTextSecondary)),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Logout', style: AppTypography.body.copyWith(color: AppColors.kError)),
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
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kError.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, color: AppColors.kError),
              SizedBox(width: 2.w),
              Text(
                "Log Out",
                style: AppTypography.h3.copyWith(color: AppColors.kError),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
