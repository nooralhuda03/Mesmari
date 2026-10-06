import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';

import 'package:mesmari_shared/core/theme/app_text.dart';

/// White input with the thin grey border used in the teacher forms.
class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.initialValue,
    this.height = 44.6,
    this.maxLines = 1,
    this.style,
    this.radius = 8.75,
    this.borderColor = const Color(0xFFE2E2E2),
    this.textDirection,
    this.fillColor,
    this.padding = const EdgeInsetsDirectional.symmetric(horizontal: 21),
  });

  final String initialValue;
  final double? height;
  final int? maxLines;
  final TextStyle? style;
  final double radius;
  final Color borderColor;
  final TextDirection? textDirection;
  final Color? fillColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        color: fillColor ?? AppColors.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 0.875),
      ),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        textDirection: textDirection,
        style: style ?? almarai(11.37, color: const Color(0xFF535353)),
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
