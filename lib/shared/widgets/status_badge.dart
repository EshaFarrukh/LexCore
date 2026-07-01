import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';

/// Semantic badge types used across the LexCore app.
enum BadgeType {
  pending,
  active,
  disposed,
  won,
  lost,
  scheduled,
  cancelled,
  pro,
  free,
}

/// A compact pill-shaped status badge that maps each [BadgeType] to a
/// label, background colour, foreground colour, and optional border.
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.type,
    this.customLabel,
    this.fontSize = 11.0,
  });

  final BadgeType type;

  /// Overrides the default label derived from [type].
  final String? customLabel;

  /// Font size of the badge label (default 11).
  final double fontSize;

  // ─── Mapping ─────────────────────────────────────────────────────────────

  static const Map<BadgeType, _BadgeStyle> _styles = {
    BadgeType.pending: _BadgeStyle(
      label: 'Pending',
      fg: AppColors.kWarning,
      bg: Color(0x22F59E0B),
    ),
    BadgeType.active: _BadgeStyle(
      label: 'Active',
      fg: AppColors.kBrandLight,
      bg: Color(0x226366F1),
    ),
    BadgeType.disposed: _BadgeStyle(
      label: 'Disposed',
      fg: AppColors.kTextSecondary,
      bg: Color(0x228B949E),
    ),
    BadgeType.won: _BadgeStyle(
      label: 'Won',
      fg: AppColors.kSuccess,
      bg: Color(0x2210B981),
    ),
    BadgeType.lost: _BadgeStyle(
      label: 'Lost',
      fg: AppColors.kError,
      bg: Color(0x22EF4444),
    ),
    BadgeType.scheduled: _BadgeStyle(
      label: 'Scheduled',
      fg: AppColors.kBrandLight,
      bg: Color(0x22818CF8),
    ),
    BadgeType.cancelled: _BadgeStyle(
      label: 'Cancelled',
      fg: AppColors.kError,
      bg: Color(0x22EF4444),
    ),
    BadgeType.pro: _BadgeStyle(
      label: 'PRO',
      fg: AppColors.kGold,
      bg: Color(0x22D4AF37),
      border: AppColors.kGold,
    ),
    BadgeType.free: _BadgeStyle(
      label: 'Free',
      fg: AppColors.kTextSecondary,
      bg: Color(0x228B949E),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final style = _styles[type]!;
    final label = customLabel ?? style.label;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(100),
        border: style.border != null
            ? Border.all(color: style.border!, width: 1)
            : null,
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: style.fg,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ─── Private style model ──────────────────────────────────────────────────────

class _BadgeStyle {
  const _BadgeStyle({
    required this.label,
    required this.fg,
    required this.bg,
    this.border,
  });

  final String label;
  final Color fg;
  final Color bg;
  final Color? border;
}
