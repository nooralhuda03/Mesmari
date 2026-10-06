import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/theme_controller.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

/// Small circular icon button (close / back).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 30,
    this.iconSize = 14,
    this.color,
    this.borderColor,
    this.bordered = true,
  });

  final String icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final Color? color;
  final Color? borderColor;

  /// Set to false for a button with no outline.
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (color ?? AppColors.surface),
          shape: BoxShape.circle,
          border: bordered
              ? Border.all(color: borderColor ?? AppColors.border)
              : null,
        ),
        child: SvgIcon(
          icon,
          size: iconSize,
          // the exported icons are dark; tint them on dark surfaces
          color: ThemeController.instance.isDark ? AppColors.text : null,
        ),
      ),
    );
  }
}
