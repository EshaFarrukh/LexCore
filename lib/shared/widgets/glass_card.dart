import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';

/// A reusable glassmorphism card with backdrop blur, subtle border,
/// and configurable appearance. Wrap any content with [GlassCard] to
/// give it the LexCore dark-glass aesthetic.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius = AppDimensions.radiusLg,
    this.borderColor,
    this.backgroundColor,
    this.onTap,
    this.boxShadow,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;

  /// Optional gradient overlay – takes precedence over [backgroundColor].
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = BorderRadius.circular(borderRadius);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: gradient == null
              ? (backgroundColor ?? AppColors.kBgElevated.withOpacity(0.82))
              : null,
          gradient: gradient,
          borderRadius: effectiveBorderRadius,
          border: Border.all(
            color: borderColor ?? AppColors.kBorder,
            width: 1.0,
          ),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 14,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: AppColors.kBrandGlow.withOpacity(0.04),
                  blurRadius: 24,
                  spreadRadius: -4,
                ),
              ],
        ),
        child: ClipRRect(
          borderRadius: effectiveBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: padding ??
                  const EdgeInsets.all(AppDimensions.cardPadding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
