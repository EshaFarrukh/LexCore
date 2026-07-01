import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';

class FailedWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final String title;
  final VoidCallback? onRetry;
  
  const FailedWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.kError),
          const SizedBox(height: 16),
          Text(title, style: AppTypography.h3),
          const SizedBox(height: 8),
          Text(
            text,
            style: AppTypography.body.copyWith(color: AppColors.kTextSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          if (onRetry != null)
            SizedBox(
              width: 200,
              child: LexButton(
                label: "Retry",
                onPressed: onRetry,
                style: LexButtonStyle.primary,
              ),
            ),
        ],
      ),
    );
  }
}
