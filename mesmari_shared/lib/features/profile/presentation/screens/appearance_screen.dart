import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Light / dark / system appearance picker.
class AppearanceScreen extends StatefulWidget {
  const AppearanceScreen({super.key});

  @override
  State<AppearanceScreen> createState() => _AppearanceScreenState();
}

class _AppearanceScreenState extends State<AppearanceScreen> {
  @override
  Widget build(BuildContext context) {
    final options = <(ThemeMode, String, IconData)>[
      (ThemeMode.light, tr('light_mode'), Icons.light_mode_outlined),
      (ThemeMode.dark, tr('dark_mode'), Icons.dark_mode_outlined),
      (ThemeMode.system, tr('system_mode'), Icons.brightness_auto_outlined),
    ];
    final current = ThemeController.instance.mode;
    return AppScreen(
      title: tr('appearance'),
      subtitle: tr('appearance_subtitle'),
      content: [
        for (final (mode, label, icon) in options)
          AppCard(
            onTap: () {
              ThemeController.instance.setMode(mode);
              setState(() {});
            },
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceAlt,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(icon, size: 17, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: almarai(14, weight: bold, color: AppColors.text),
                  ),
                ),
                Icon(
                  current == mode ? Icons.check_circle : Icons.circle_outlined,
                  size: 22,
                  color: current == mode ? AppColors.primary : AppColors.border,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
