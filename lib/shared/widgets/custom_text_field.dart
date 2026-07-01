import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? fillColor;
  final double? borderRadius;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.textColor,
    this.hintTextColor,
    this.fillColor,
    this.borderRadius,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  static final OutlineInputBorder _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.kBorder, width: 1.0),
  );

  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.kBrand, width: 2.0),
  );

  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: AppColors.kError, width: 1.5),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      onChanged: onChanged,
      maxLines: obscureText ? 1 : maxLines,
      readOnly: readOnly,
      onTap: onTap,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted ?? (v) => FocusScope.of(context).unfocus(),
      style: AppTypography.body.copyWith(
        color: textColor ?? AppColors.kTextPrimary,
      ),
      cursorColor: AppColors.kBrand,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.kBgElevated,
        enabledBorder: borderRadius != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: const BorderSide(color: AppColors.kBorder, width: 1.0),
              )
            : _defaultBorder,
        focusedBorder: borderRadius != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius!),
                borderSide: const BorderSide(color: AppColors.kBrand, width: 2.0),
              )
            : _focusedBorder,
        errorBorder: _errorBorder,
        focusedErrorBorder: _errorBorder,
        disabledBorder: _defaultBorder,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.lg,
          vertical: AppDimensions.md + 4,
        ),
        hintStyle: AppTypography.body.copyWith(
          color: hintTextColor ?? AppColors.kTextSecondary.withValues(alpha: 0.7),
        ),
        errorStyle: AppTypography.captionError,
      ),
    );
  }
}
