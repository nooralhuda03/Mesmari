import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';

/// Rounded label chip.
class Pill extends StatelessWidget {
  const Pill(
    this.label, {
    super.key,
    this.color,
    this.textStyle,
    this.width,
    this.height = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
  });

  final String label;
  final Color? color;
  final TextStyle? textStyle;
  final double? width;
  final double height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (color ?? AppColors.mint),
        borderRadius: BorderRadius.circular(height),
      ),
      child: Text(
        label,
        style: textStyle ?? almarai(12, weight: bold, color: AppColors.primary),
      ),
    );
  }
}
