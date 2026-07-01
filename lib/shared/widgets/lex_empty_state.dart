import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

/// A beautiful, animated empty-state placeholder widget.
///
/// Shows a large icon inside a brand-glow halo, a bold heading, a descriptive
/// subtitle, and an optional CTA button with a brand-gradient fill.
///
/// ```dart
/// LexEmptyState(
///   icon: Icons.gavel_rounded,
///   title: 'No Cases Yet',
///   subtitle: 'Your active cases will appear here once added.',
///   buttonLabel: 'Add Case',
///   onButton: () => context.push(RouteNames.addCase),
/// )
/// ```
class LexEmptyState extends StatelessWidget {
  const LexEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onButton,
    this.iconColor,
  });

  /// Icon displayed in the brand-glow circle.
  final IconData icon;

  /// Bold heading text.
  final String title;

  /// Descriptive text beneath the heading.
  final String subtitle;

  /// Label for the optional CTA button.
  final String? buttonLabel;

  /// Callback for the optional CTA button.
  final VoidCallback? onButton;

  /// Tint applied to the icon; defaults to [AppColors.kBrandLight].
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final brandColor = iconColor ?? AppColors.kBrandLight;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.xxxl,
          vertical: AppDimensions.huge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon halo ──────────────────────────────────────────────────
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: brandColor.withValues(alpha: 0.10),
                border: Border.all(
                  color: brandColor.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: brandColor.withValues(alpha: 0.18),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 46,
                color: brandColor,
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .scaleXY(begin: 0.7, duration: 500.ms, curve: Curves.elasticOut),

            const SizedBox(height: AppDimensions.xxl),

            // ── Title ──────────────────────────────────────────────────────
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(
                fontSize: 20,
                letterSpacing: -0.3,
              ),
            )
                .animate(delay: 150.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, duration: 400.ms),

            const SizedBox(height: AppDimensions.sm),

            // ── Subtitle ───────────────────────────────────────────────────
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(
                color: AppColors.kTextSecondary,
                height: 1.6,
              ),
            )
                .animate(delay: 250.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, duration: 400.ms),

            // ── Optional CTA ───────────────────────────────────────────────
            if (buttonLabel != null && onButton != null) ...[
              const SizedBox(height: AppDimensions.xxxl),
              _CTAButton(label: buttonLabel!, onTap: onButton!, color: brandColor)
                  .animate(delay: 350.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.3, duration: 400.ms),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Private CTA Button ───────────────────────────────────────────────────────

class _CTAButton extends StatefulWidget {
  const _CTAButton({
    required this.label,
    required this.onTap,
    required this.color,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.xxxl,
            vertical: AppDimensions.md + 2,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.color, const Color(0xFF7C3AED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: AppTypography.button.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
