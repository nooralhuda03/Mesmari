import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/theme_controller.dart';

import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

/// White stat box: optional icon, value and label, all centred.
class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.iconSize = 18,
    this.height = 104.8,
    this.useCairo = true,
    this.borderColor,
    this.radius = 9.28,
  });

  final String value;
  final String label;
  final String? icon;
  final double iconSize;
  final double height;
  final bool useCairo;
  final Color? borderColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final valueStyle = useCairo
        ? cairo(15, weight: bold)
        : almarai(14, weight: bold);
    final labelStyle = useCairo
        ? cairo(12, color: const Color(0xFF9C9C9C))
        : almarai(12, color: const Color(0xFF7E7E7E));
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: (borderColor ?? const Color(0x3B004957)),
          width: 0.93,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgIcon(
              icon!,
              size: iconSize,
              color: ThemeController.instance.isDark ? AppColors.primary : null,
            ),
            const SizedBox(height: 4),
          ],
          Text(value, style: valueStyle),
          Text(label, style: labelStyle),
        ],
      ),
    );
  }
}
