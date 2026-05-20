import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
  });
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            Text(
              label.toUpperCase(),
              style: AppTypography.labelMd.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: AppTypography.body.copyWith(color: AppColors.primary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.body.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.surfaceContianerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(99),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(99),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(99),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
