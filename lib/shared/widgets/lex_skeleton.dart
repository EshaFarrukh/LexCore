import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';

// ─── Colours (dark-mode shimmer palette) ─────────────────────────────────────
const _kShimmerBase = Color(0xFF1C2128);
const _kShimmerHighlight = Color(0xFF2D3748);

// ─── LexSkeleton ─────────────────────────────────────────────────────────────

/// A single shimmer block of configurable size and border-radius.
/// Use this as the primitive building block for custom skeleton layouts.
///
/// ```dart
/// LexSkeleton(width: double.infinity, height: 20, borderRadius: 8)
/// ```
class LexSkeleton extends StatelessWidget {
  const LexSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppDimensions.radiusSm,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kShimmerBase,
      highlightColor: _kShimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _kShimmerBase,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// ─── LexSkeletonCard ─────────────────────────────────────────────────────────

/// Pre-built skeleton that matches the visual footprint of a case/document
/// list card: a leading square icon placeholder, a wide title bar, and a
/// narrower subtitle bar.
class LexSkeletonCard extends StatelessWidget {
  const LexSkeletonCard({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kShimmerBase,
      highlightColor: _kShimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Container(
        margin: margin ??
            const EdgeInsets.only(bottom: AppDimensions.md),
        padding: const EdgeInsets.all(AppDimensions.cardPadding),
        decoration: BoxDecoration(
          color: _kShimmerBase,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          border: Border.all(
            color: const Color(0xFF30363D),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Leading icon placeholder ─────────────────────────────────
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _kShimmerHighlight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
            ),

            const SizedBox(width: AppDimensions.md),

            // ── Text lines ───────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  // Title line
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _kShimmerHighlight,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  // Subtitle line (shorter)
                  Container(
                    height: 11,
                    width: 160,
                    decoration: BoxDecoration(
                      color: _kShimmerHighlight,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSm),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.sm),
                  // Badge placeholder
                  Container(
                    height: 20,
                    width: 72,
                    decoration: BoxDecoration(
                      color: _kShimmerHighlight,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusFull),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── LexSkeletonList ─────────────────────────────────────────────────────────

/// Renders [itemCount] stacked [LexSkeletonCard] widgets inside a [Column].
/// Drop this directly into a screen body while data is loading.
///
/// ```dart
/// if (isLoading) const LexSkeletonList(itemCount: 5)
/// ```
class LexSkeletonList extends StatelessWidget {
  const LexSkeletonList({
    super.key,
    this.itemCount = 4,
    this.padding,
  });

  final int itemCount;

  /// Padding applied around the entire list.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: List.generate(
          itemCount,
          (i) => LexSkeletonCard(
            margin: EdgeInsets.only(
              bottom: i < itemCount - 1 ? AppDimensions.md : 0,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── LexSkeletonRow ──────────────────────────────────────────────────────────

/// Horizontal skeleton row – useful for profile header or stat-row shimmer.
class LexSkeletonRow extends StatelessWidget {
  const LexSkeletonRow({
    super.key,
    this.height = 60,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kShimmerBase,
      highlightColor: _kShimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Row(
        children: [
          Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              color: _kShimmerHighlight,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppDimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _kShimmerHighlight,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                ),
                const SizedBox(height: AppDimensions.sm),
                Container(
                  height: 11,
                  width: 120,
                  decoration: BoxDecoration(
                    color: _kShimmerHighlight,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
