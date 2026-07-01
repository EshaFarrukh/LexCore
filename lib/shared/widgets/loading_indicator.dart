import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_typography.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;
  final String? text;
  final Color? textColor;

  const LoadingIndicator({
    super.key,
    this.color,
    this.size = 24.0,
    this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.kBrandLight,
              ),
              strokeWidth: 2.0,
            ),
          ),
          if (text != null) ...[
            const SizedBox(height: 12),
            Text(
              text!,
              style: AppTypography.body.copyWith(color: textColor ?? AppColors.kTextSecondary),
            ),
          ]
        ],
      ),
    );
  }
}
