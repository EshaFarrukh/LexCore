import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/core/utils/storage/storage_service.dart';
import 'package:lex_core/app/router/route_names.dart';
import 'package:sizer/sizer.dart';

class CustomClientDrawer extends StatelessWidget {
  const CustomClientDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.kBgSurface.withValues(alpha: 0.94),
              AppColors.kBgElevated.withValues(alpha: 0.88),
            ],
          ),
          border: Border(
            right: BorderSide(
              color: AppColors.kBrandLight.withValues(alpha: 0.18),
              width: 1.4,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              blurRadius: 32,
              offset: const Offset(8, 0),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 2.h),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.kBrandLight.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.home_rounded,
                        color: AppColors.kBrandLight,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Client Panel',
                      style: AppTypography.h2,
                    ),
                  ],
                ),
              ),

              const Divider(
                color: AppColors.kBorder,
                height: 1,
                thickness: 1.2,
                indent: 20,
                endIndent: 20,
              ),

              SizedBox(height: 2.h),

              // Drawer items (placeholder for future items)
              _buildDrawerItem(
                icon: Icons.dashboard_customize_rounded,
                title: 'Dashboard',
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              // TODO: Add more drawer items here as needed

              const Spacer(),

              // Logout item styled like lawyer drawer
              Padding(
                padding: EdgeInsets.fromLTRB(6.w, 2.h, 6.w, 5.h),
                child: _buildDrawerItem(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  color: AppColors.kError,
                  onTap: () => _confirmAndLogout(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    final itemColor = color ?? AppColors.kTextPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.6.h),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: itemColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: itemColor, size: 26),
            ),
            SizedBox(width: 5.w),
            Text(
              title,
              style: AppTypography.h3.copyWith(color: itemColor),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmAndLogout(BuildContext context) async {
    final rootContext = context;

    final bool? confirmed = await showDialog<bool>(
      context: rootContext,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.kBgSurface.withValues(alpha: 0.96),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Logout',
            style: AppTypography.h2,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTypography.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancel',
                style: AppTypography.body.copyWith(color: AppColors.kTextSecondary),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Logout',
                style: AppTypography.body.copyWith(color: AppColors.kError),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await StorageService.instance.clearAllAuthData();
      Navigator.of(rootContext).pop();
      rootContext.goNamed(RouteNames.incomingUserScreen);
    }
  }
}

