import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

/// A compact horizontal row that shows a labelled icon on the left and a
/// value on the right.  Used consistently across Case Details, Lawyer
/// Profiles, Client Profiles, and similar read-only data screens.
///
/// ```dart
/// InfoRow(
///   icon: Icons.phone_rounded,
///   label: 'Phone',
///   value: '+92 300 1234567',
///   iconColor: AppColors.kBrandLight,
/// )
/// ```
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.showDivider = true,
    this.onTap,
  });

  /// Leading icon.
  final IconData icon;

  /// Descriptor label in secondary text colour.
  final String label;

  /// Data value displayed right-aligned in primary colour.
  final String value;

  /// Tint applied to the leading icon; defaults to [AppColors.kBrandLight].
  final Color? iconColor;

  /// Render a thin divider line beneath the row.
  final bool showDivider;

  /// Optional tap handler – adds a trailing chevron when set.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.kBrandLight;
    final isTappable = onTap != null;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Icon ─────────────────────────────────────────────────
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: effectiveIconColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    size: AppDimensions.iconMd - 2,
                    color: effectiveIconColor,
                  ),
                ),

                const SizedBox(width: AppDimensions.md),

                // ── Label ─────────────────────────────────────────────────
                Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    style: AppTypography.caption.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(width: AppDimensions.sm),

                // ── Value ─────────────────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: AppTypography.body.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // ── Optional chevron ──────────────────────────────────────
                if (isTappable) ...[
                  const SizedBox(width: AppDimensions.xs),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: AppColors.kTextSecondary,
                  ),
                ],
              ],
            ),
          ),

          // ── Optional divider ─────────────────────────────────────────────
          if (showDivider)
            const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.kBorder,
            ),
        ],
      ),
    );
  }
}
