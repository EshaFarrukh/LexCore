import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';

/// A two-line section header widget with an optional "See All" action button
/// aligned to the right. Used as dividers between content blocks on list
/// screens throughout the app.
///
/// ```dart
/// SectionHeader(
///   title: 'Active Cases',
///   subtitle: '3 ongoing matters',
///   actionLabel: 'See All',
///   onAction: () => context.push(RouteNames.cases),
/// )
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    this.titleStyle,
    this.bottomPadding = AppDimensions.md,
  });

  /// Main heading text (h3 weight).
  final String title;

  /// Optional descriptive text shown below [title] in secondary colour.
  final String? subtitle;

  /// Label for the right-aligned tap action (e.g. "See All").
  final String? actionLabel;

  /// Callback fired when the right-side action is tapped.
  final VoidCallback? onAction;

  /// Override default title text style.
  final TextStyle? titleStyle;

  /// Vertical gap added beneath the header row.
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title row ──────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ??
                      GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kTextPrimary,
                        letterSpacing: -0.2,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Optional action button
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(width: AppDimensions.sm),
                GestureDetector(
                  onTap: onAction,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.xs,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionLabel!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBrandLight,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11,
                          color: AppColors.kBrandLight,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),

          // ── Optional subtitle ──────────────────────────────────────────
          if (subtitle != null) ...[
            const SizedBox(height: 3),
            Text(
              subtitle!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.kTextSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
