import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/shared/widgets/glass_card.dart';

/// A compact metric card that displays a labelled value with a coloured
/// icon and an optional trend chip.
///
/// Uses [GlassCard] as its backdrop so it fits seamlessly in any dark-glass
/// layout. Typically displayed in a 2-column grid on dashboard screens.
///
/// ```dart
/// StatCard(
///   label: 'Active Cases',
///   value: '24',
///   icon: Icons.gavel_rounded,
///   color: AppColors.kBrandLight,
///   trend: '+3 this month',
///   trendPositive: true,
/// )
/// ```
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
    this.trendPositive = true,
    this.onTap,
  });

  /// Short descriptive label shown below the value.
  final String label;

  /// Large metric value (e.g. "24", "₨ 1.2M").
  final String value;

  final IconData icon;

  /// Accent colour used for the icon circle and value text tint.
  final Color color;

  /// Optional trend string (e.g. "+12%" or "3 pending").
  final String? trend;

  /// Controls whether the trend chip uses [AppColors.kSuccess] or [AppColors.kError].
  final bool trendPositive;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      borderColor: color.withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Icon circle + trend chip row ─────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon in tinted circle
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  border: Border.all(
                    color: color.withValues(alpha: 0.28),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: color, size: AppDimensions.iconMd),
              ),

              const Spacer(),

              // Trend chip
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.sm,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: (trendPositive
                            ? AppColors.kSuccess
                            : AppColors.kError)
                        .withValues(alpha: 0.14),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendPositive
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 11,
                        color: trendPositive
                            ? AppColors.kSuccess
                            : AppColors.kError,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        trend!,
                        style: AppTypography.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: trendPositive
                              ? AppColors.kSuccess
                              : AppColors.kError,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppDimensions.md),

          // ── Value ──────────────────────────────────────────────────────
          Text(
            value,
            style: AppTypography.h1.copyWith(
              fontSize: 26,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 3),

          // ── Label ──────────────────────────────────────────────────────
          Text(
            label,
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
