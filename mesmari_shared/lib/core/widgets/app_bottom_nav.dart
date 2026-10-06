import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/theme_controller.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/svg_icon.dart';

class NavItem {
  const NavItem(this.label, this.icon, this.activeIcon, {this.activeTint});

  final String label;
  final String icon;
  final String activeIcon;

  /// Tint applied to [activeIcon] when the exported asset isn't coloured.
  final Color? activeTint;
}

/// White bottom bar.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.card),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(child: _buildItem(items[i], i == currentIndex, i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(NavItem item, bool active, int index) {
    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            SvgIcon(
              active ? item.activeIcon : item.icon,
              size: 20,
              color: ThemeController.instance.isDark
                  ? (active ? AppColors.primary : AppColors.navInactive)
                  : (active ? item.activeTint : null),
            ),
            const SizedBox(height: 5),
            Text(
              item.label,
              style: cairo(
                12,
                weight: active ? bold : FontWeight.w400,
                color: active ? AppColors.primary : AppColors.navInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
