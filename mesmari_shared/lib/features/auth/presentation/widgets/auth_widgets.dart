import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// White rounded input used on the auth screens.
class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.hintStyle,
    this.textDirection,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.inputBorder),
    );
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlign: TextAlign.right,
        textDirection: textDirection,
        style: almarai(15, color: AppColors.text),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle ?? almarai(15, color: AppColors.hint),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}

/// Title + body text block shown under the logo.
class AuthHeading extends StatelessWidget {
  const AuthHeading({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: cairo(24, weight: bold, color: AppColors.authTitle),
        ),
        const SizedBox(height: 2),
        Text(
          body,
          style: tajawal(14, color: AppColors.authBody, height: 22 / 14),
        ),
      ],
    );
  }
}
