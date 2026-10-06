import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

/// Dark teal filled button used across the app.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 52,
    this.width = double.infinity,
    this.radius = 12,
    this.icon,
    this.iconSize = 16,
    this.style,
    this.color,
  });

  final String label;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final double radius;
  final String? icon;
  final double iconSize;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: (color ?? AppColors.primary),
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style:
                    style ?? cairo(16, weight: semiBold, color: Colors.white),
              ),
              if (icon != null) ...[
                const SizedBox(width: 12),
                SvgIcon(icon!, size: iconSize),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
