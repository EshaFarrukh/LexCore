import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

/// A replacement for `CustomAppbar` that implements [PreferredSizeWidget]
/// so it drops directly into [Scaffold.appBar].
///
/// Features:
/// - Optional brand logo (gradient "L" + "exCore" text)
/// - Optional plain title string
/// - Automatic back button in brand colour
/// - Optional notification bell icon
/// - Fully transparent / glass background by default
///
/// ```dart
/// Scaffold(
///   appBar: LexAppBar(
///     title: 'Active Cases',
///     showBack: true,
///     actions: [/* ... */],
///   ),
/// )
/// ```
class LexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LexAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.showLogo = false,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.showNotificationIcon = false,
    this.onNotificationTap,
  });

  /// Plain text title shown in the centre / left of the bar.
  final String? title;

  /// Whether to render a leading back chevron.
  final bool showBack;

  /// Whether to render the LexCore brand logo instead of [title].
  final bool showLogo;

  final List<Widget>? actions;
  final Color backgroundColor;

  /// When true, appends a notification bell button to [actions].
  final bool showNotificationIcon;
  final VoidCallback? onNotificationTap;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: AppDimensions.appBarHeight,
      automaticallyImplyLeading: false,

      // ── Leading – back button ─────────────────────────────────────────
      leading: showBack
          ? _BackButton(context: context)
          : null,

      // ── Centre – logo or title ────────────────────────────────────────
      title: showLogo
          ? const _LexCoreLogo()
          : title != null
              ? Text(
                  title!,
                  style: AppTypography.h3.copyWith(
                    letterSpacing: -0.2,
                  ),
                )
              : null,

      centerTitle: showLogo,

      // ── Actions ──────────────────────────────────────────────────────
      actions: [
        if (showNotificationIcon)
          _NotificationButton(onTap: onNotificationTap),
        ...?actions,
        const SizedBox(width: AppDimensions.sm),
      ],
    );
  }
}

// ─── Back Button ─────────────────────────────────────────────────────────────

class _BackButton extends StatelessWidget {
  const _BackButton({required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.sm),
      child: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.kBgElevated,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(color: AppColors.kBorder, width: 1),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.kBrandLight,
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}

// ─── Notification Button ──────────────────────────────────────────────────────

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.xs),
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppColors.kTextSecondary,
              size: AppDimensions.iconLg,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          // Unread dot
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.kBrandLight,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── LexCore Logo ─────────────────────────────────────────────────────────────

/// Renders "LexCore" with the "L" in a brand-to-violet gradient sheen and
/// the remainder in primary text colour.
class _LexCoreLogo extends StatelessWidget {
  const _LexCoreLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Gradient "L"
        ShaderMask(
          shaderCallback: (bounds) => AppColors.kBrandGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            'L',
            style: AppTypography.h1.copyWith(
              color: Colors.white, // masked by shader
              letterSpacing: -0.5,
            ),
          ),
        ),
        Text(
          'exCore',
          style: AppTypography.h1.copyWith(
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
