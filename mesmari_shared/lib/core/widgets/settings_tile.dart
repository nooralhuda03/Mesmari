import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/theme_controller.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

/// Settings row used in both profile screens.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    this.icon,
    this.iconData,
    this.iconWidth = 15,
    this.iconHeight = 15,
    this.iconBg,
    this.danger = false,
    this.onTap,
  });

  final String label;

  /// SVG asset name from the design.
  final String? icon;

  /// Material icon, for screens that have no exported asset.
  final IconData? iconData;
  final double iconWidth;
  final double iconHeight;
  final Color? iconBg;
  final bool danger;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.tileBorder),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: SizedBox(
            height: 63,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 17, end: 15),
              child: Row(
                children: [
                  Container(
                    width: 31,
                    height: 31,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: (iconBg ?? AppColors.surfaceAlt),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: icon != null
                        ? SvgIcon(
                            icon!,
                            width: iconWidth,
                            height: iconHeight,
                            color: danger
                                ? null
                                : (ThemeController.instance.isDark
                                      ? AppColors.primary
                                      : null),
                          )
                        : Icon(iconData, size: 16, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      label,
                      style: cairo(
                        14,
                        color: danger ? AppColors.red : AppColors.text,
                      ),
                    ),
                  ),
                  const SvgIcon('chevron_left', size: 13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
