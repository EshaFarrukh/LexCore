import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

enum LexButtonStyle { primary, secondary, outline, ghost, danger }

class LexButton extends StatefulWidget {
  const LexButton({
    super.key,
    required this.label,
    this.onPressed,
    this.style = LexButtonStyle.primary,
    this.isLoading = false,
    this.prefixIcon,
    this.fullWidth = false,
    this.height = 56.0, // Increased height for premium feel
  });

  final String label;
  final VoidCallback? onPressed;
  final LexButtonStyle style;
  final bool isLoading;
  final IconData? prefixIcon;
  final bool fullWidth;
  final double height;

  @override
  State<LexButton> createState() => _LexButtonState();
}

class _LexButtonState extends State<LexButton>
    with SingleTickerProviderStateMixin {
  bool _pressed = false;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  Color get _backgroundColor {
    if (!_isEnabled) return AppColors.kBorder;
    switch (widget.style) {
      case LexButtonStyle.primary:
        return AppColors.kSurfaceInverted; // Premium Black Pill
      case LexButtonStyle.secondary:
        return AppColors.kBrand; // Premium Blue Accent
      case LexButtonStyle.danger:
        return AppColors.kError;
      case LexButtonStyle.outline:
      case LexButtonStyle.ghost:
        return Colors.transparent;
    }
  }

  Color get _labelColor {
    if (!_isEnabled) return AppColors.kTextTertiary;
    switch (widget.style) {
      case LexButtonStyle.primary:
      case LexButtonStyle.secondary:
      case LexButtonStyle.danger:
        return Colors.white;
      case LexButtonStyle.outline:
      case LexButtonStyle.ghost:
        return AppColors.kTextPrimary;
    }
  }

  Border? get _border {
    switch (widget.style) {
      case LexButtonStyle.outline:
        return Border.all(
          color: _isEnabled ? AppColors.kBorder : AppColors.kBorder,
          width: 1.5,
        );
      default:
        return null;
    }
  }

  List<BoxShadow>? get _shadows {
    if (!_isEnabled) return null;
    switch (widget.style) {
      case LexButtonStyle.primary:
        return [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ];
      case LexButtonStyle.secondary:
        return [
          BoxShadow(
            color: AppColors.kBrand.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ];
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _isEnabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _isEnabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: _isEnabled ? () => setState(() => _pressed = false) : null,
      onTap: _isEnabled ? () {
        // Optional haptic feedback can be added here
        widget.onPressed?.call();
      } : null,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutQuart,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _isEnabled ? 1.0 : 0.6,
          child: Container(
            width: widget.fullWidth ? double.infinity : null,
            height: widget.height,
            padding: EdgeInsets.symmetric(horizontal: widget.fullWidth ? 0 : 32),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(999), // Fully rounded pill
              border: _border,
              boxShadow: _shadows,
            ),
            alignment: Alignment.center,
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation(_labelColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(
                          widget.prefixIcon,
                          color: _labelColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: AppTypography.button.copyWith(color: _labelColor),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
