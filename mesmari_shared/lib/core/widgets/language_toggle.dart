import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';

/// Compact "عربي | English" switch, shown on the auth screens.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final code = LocaleController.instance.languageCode;
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _option('عربي', 'ar', code == 'ar'),
              _option('English', 'en', code == 'en'),
            ],
          ),
        );
      },
    );
  }

  Widget _option(String label, String value, bool selected) {
    return GestureDetector(
      onTap: () => LocaleController.instance.setLanguage(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: almarai(
            11.5,
            weight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.muted,
          ),
        ),
      ),
    );
  }
}
