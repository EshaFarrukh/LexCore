import 'package:flutter/material.dart';
import 'package:lex_core/core/constants/app_colors.dart';
import 'package:lex_core/core/constants/app_dimensions.dart';
import 'package:lex_core/core/constants/app_typography.dart';

class LexTextField extends StatelessWidget {
  const LexTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.label,
    this.prefixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
    this.autofillHints,
    this.maxLength,
    this.textAlign = TextAlign.start,
  });

  final TextEditingController controller;
  final String hintText;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final int? maxLength;
  final TextAlign textAlign;

  static final OutlineInputBorder _defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide.none,
  );

  static final OutlineInputBorder _focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.kBrand, width: 1.5),
  );

  static final OutlineInputBorder _errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.kError, width: 1.5),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              label!,
              style: AppTypography.label.copyWith(color: AppColors.kTextPrimary),
            ),
          ),
          const SizedBox(height: 8),
        ],

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            maxLines: obscureText ? 1 : maxLines,
            onTap: onTap,
            readOnly: readOnly,
            onChanged: onChanged,
            textInputAction: textInputAction,
            focusNode: focusNode,
            autofillHints: autofillHints,
            maxLength: maxLength,
            textAlign: textAlign,
            style: AppTypography.bodyMedium,
            cursorColor: AppColors.kBrand,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.kTextTertiary,
              ),
              filled: true,
              fillColor: AppColors.kInputBg,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              enabledBorder: _defaultBorder,
              focusedBorder: _focusedBorder,
              errorBorder: _errorBorder,
              focusedErrorBorder: _errorBorder,
              disabledBorder: _defaultBorder,
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      size: 22,
                      color: AppColors.kTextTertiary,
                    )
                  : null,
              suffixIcon: suffixWidget,
              errorStyle: AppTypography.captionError,
            ),
          ),
        ),
      ],
    );
  }
}
