import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/features/lawyer/domain/entities/lawyer_entity.dart';
import 'package:lex_core/shared/widgets/custom_appbar.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';
import 'package:sizer/sizer.dart';

class LawyerProfileScreen extends StatelessWidget {
  final LawyerEntity lawyer;

  const LawyerProfileScreen({super.key, required this.lawyer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(
        isBack: true,
        title: '${lawyer.firstName} ${lawyer.lastName}',
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        color: AppColors.kBgDeep,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  child: Column(
                    children: [
                      // Avatar overlapping the header
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.kBrandLight,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            width: 22.h,
                            height: 22.h,
                            child: CachedNetworkImage(
                              imageUrl: lawyer.profilePhoto,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.kBgSurface,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kBrandLight,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.kBgSurface,
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 80,
                                  color: AppColors.kTextSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 2.h),

                      // Name & rating
                      Text(
                        '${lawyer.firstName} ${lawyer.lastName}',
                        style: AppTypography.h1,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        lawyer.email,
                        style: AppTypography.body,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        lawyer.phone,
                        style: AppTypography.body,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.kGold,
                            size: 22,
                          ),
                          SizedBox(width: 1.5.w),
                          Text(
                            lawyer.rating.toStringAsFixed(1),
                            style: AppTypography.h3.copyWith(color: AppColors.kGold),
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '(${lawyer.reviews} reviews)',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),
                      Text(
                        lawyer.category,
                        style: AppTypography.h3.copyWith(color: AppColors.kBrandLight),
                      ),

                      SizedBox(height: 4.h),

                      // Biography & Description
                      _buildSection('Biography', lawyer.biography),
                      SizedBox(height: 3.h),
                      _buildSection('Description', lawyer.description),

                      SizedBox(height: 5.h),

                      // Book Now Button
                      LexButton(
                        label: 'Book Consultation',
                        style: LexButtonStyle.primary,
                        fullWidth: true,
                        onPressed: () {
                          // TODO: Navigate to booking flow
                        },
                      ),

                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.h2),
        SizedBox(height: 1.2.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.kBgSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Text(
            content,
            style: AppTypography.body,
          ),
        ),
      ],
    );
  }
}

