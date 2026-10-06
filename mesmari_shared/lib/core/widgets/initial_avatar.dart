import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';

/// Circle with a single Arabic initial.
class InitialAvatar extends StatelessWidget {
  const InitialAvatar(
    this.letter, {
    super.key,
    this.size = 30,
    this.color,
    this.fontSize = 12,
  });

  final String letter;
  final double size;
  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (color ?? AppColors.primary),
        shape: BoxShape.circle,
      ),
      child: Text(
        letter,
        style: tajawal(fontSize, weight: bold, color: Colors.white),
      ),
    );
  }
}
