import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lex_core/core/constants/app_assets.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/features/student/data/models/certification_model.dart';
import 'package:lex_core/features/student/presentation/providers/certifications_provider/certification_provider.dart';
import 'package:lex_core/shared/widgets/custom_appbar.dart';
import 'package:lex_core/shared/widgets/custom_button.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:lex_core/shared/widgets/failed_widget.dart';
import 'package:lex_core/shared/widgets/loading_indicator.dart';
import 'package:lex_core/features/student/presentation/widgets/certification_widgets/certification_item_widget.dart';
import 'package:sizer/sizer.dart';

import 'package:lex_core/features/student/presentation/widgets/student_portal_header.dart';

class CertificationScreen extends ConsumerStatefulWidget {
  const CertificationScreen({super.key});

  @override
  ConsumerState<CertificationScreen> createState() =>
      _CertificationScreenState();
}

class _CertificationScreenState extends ConsumerState<CertificationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(certificationControllerProvider.notifier).getAllCertifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final certificationState = ref.watch(certificationControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StudentPortalHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Certifications",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enhance your skills with professional certifications",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Expanded(
              child: certificationState.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
                failure: (error) => Center(
                  child: FailedWidget(
                    title: "Failed to load certifications",
                    text: error,
                    icon: Icons.error_outline_rounded,
                    onRetry: () => ref
                        .read(certificationControllerProvider.notifier)
                        .getAllCertifications(),
                  ),
                ),
                success: (data) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  itemCount: data.availableCertifications.length,
                  itemBuilder: (context, index) {
                    final certification = data.availableCertifications[index];
                    return CertificationItemWidget(
                      certification: certification,
                      isCompleted: false,
                      onTap: () => _showCertificationDetails(context, certification),
                      onEnroll: () => _enrollInCertification(context, certification),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
    );
  }

  void _enrollInCertification(
    BuildContext context,
    CertificationModel certification,
  ) {
    ref
        .read(certificationControllerProvider.notifier)
        .enrollInCertification(certification.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully enrolled in "${certification.title}"'),
        backgroundColor: AppColors.kEmerald,
      ),
    );
  }

  void _showCertificationDetails(
    BuildContext context,
    CertificationModel certification,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.kSurface.withValues(alpha: 0.96),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: CustomText(
          title: certification.title,
          color: AppColors.kTextPrimary,
          fontSize: 20.sp,
          weight: FontWeight.w700,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: certification.description,
              color: AppColors.kTextSecondary,
              fontSize: 16.sp,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Icon(Icons.person, size: 6.w, color: AppColors.kEmerald),
                SizedBox(width: 1.w),
                CustomText(
                  title: 'Instructor: ${certification.instructor}',
                  color: AppColors.kTextSecondary,
                  fontSize: 15.sp,
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            Row(
              children: [
                Icon(Icons.schedule, size: 6.w, color: AppColors.kEmerald),
                SizedBox(width: 1.w),
                CustomText(
                  title: 'Duration: ${certification.duration}',
                  color: AppColors.kTextSecondary,
                  fontSize: 15.sp,
                ),
              ],
            ),
            SizedBox(height: 0.5.h),
            Row(
              children: [
                Icon(Icons.bar_chart, size: 6.w, color: AppColors.kEmerald),
                SizedBox(width: 1.w),
                CustomText(
                  title: 'Level: ${certification.level}',
                  color: AppColors.kTextSecondary,
                  fontSize: 15.sp,
                ),
              ],
            ),
            if (certification.skills.isNotEmpty) ...[
              SizedBox(height: 1.h),
              CustomText(
                title: 'Skills:',
                color: AppColors.kTextPrimary,
                fontSize: 15.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 0.5.h),
              Wrap(
                spacing: 1.w,
                runSpacing: 0.5.h,
                children: certification.skills
                    .map(
                      (skill) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 1.5.w,
                          vertical: 0.3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kEmerald.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CustomText(
                          title: skill,
                          color: AppColors.kEmerald,
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
        actions: [
          CustomButton(
            text: "Close",
            onPressed: () => Navigator.pop(context),
            backgroundColor: AppColors.kEmeraldDark,
            textColor: Colors.white,
          ),
          CustomButton(
            text: "Enroll",
            onPressed: () {
              Navigator.pop(context);
              _enrollInCertification(context, certification);
            },
            backgroundColor: AppColors.kEmerald,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

