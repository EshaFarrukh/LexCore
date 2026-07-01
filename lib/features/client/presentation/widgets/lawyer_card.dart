import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/shared/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class LawyerCard extends StatelessWidget {
  final String? profileImage;
  final String? firstName;
  final String? lastName;
  final double? ratings;
  final VoidCallback onTap;

  const LawyerCard({
    super.key,
    this.profileImage,
    this.firstName,
    this.lastName,
    this.ratings,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Safe name handling
    final displayName = [
      firstName?.trim() ?? '',
      lastName?.trim() ?? '',
    ].where((s) => s.isNotEmpty).join(' ');

    final safeName = displayName.isNotEmpty ? displayName : 'Lawyer';

    // Safe rating (0â€“5)
    final safeRating = (ratings ?? 0.0).clamp(0.0, 5.0);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
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
            // Profile Image
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
              ),
              child: CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFFE2E8F0),
                backgroundImage: profileImage != null &&
                        profileImage!.trim().isNotEmpty &&
                        Uri.tryParse(profileImage!.trim())?.hasScheme == true
                    ? CachedNetworkImageProvider(profileImage!.trim())
                    : null,
                child: (profileImage == null || profileImage!.trim().isEmpty)
                    ? const Icon(Icons.person_rounded, size: 36, color: Color(0xFF94A3B8))
                    : null,
              ),
            ),

            SizedBox(width: 4.w),

            // Name & rating
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    safeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFF59E0B),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        safeRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "•  Available",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}

