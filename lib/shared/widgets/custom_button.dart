import 'package:flutter/material.dart';
import 'package:lex_core/shared/widgets/lex_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isOutlined;
  final bool isLoading;
  final IconData? icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? blurRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.isOutlined = false,
    this.isLoading = false,
    this.icon,
    this.fontSize,
    this.fontWeight,
    this.blurRadius = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: LexButton(
        label: text,
        onPressed: onPressed ?? () {},
        style: isOutlined ? LexButtonStyle.outline : LexButtonStyle.primary,
        prefixIcon: icon,
        isLoading: isLoading,
        fullWidth: width == null || width == double.infinity,
      ),
    );
  }
}
