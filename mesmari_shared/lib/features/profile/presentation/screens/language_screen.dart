import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// App language picker — switching applies immediately.
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late String _selected = LocaleController.instance.languageCode;

  @override
  Widget build(BuildContext context) {
    final languages = [
      (tr('arabic'), tr('iraq'), 'ar'),
      (tr('english'), tr('united_states'), 'en'),
    ];
    return AppScreen(
      title: tr('language'),
      subtitle: tr('app_language'),
      content: [
        for (final (name, region, code) in languages)
          AppCard(
            onTap: () {
              setState(() => _selected = code);
              LocaleController.instance.setLanguage(code);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: almarai(14, weight: bold, color: AppColors.text),
                      ),
                      Text(region, style: almarai(11, color: AppColors.muted)),
                    ],
                  ),
                ),
                if (_selected == code)
                  Icon(Icons.check_circle, color: AppColors.primary, size: 22)
                else
                  Icon(
                    Icons.circle_outlined,
                    color: AppColors.border,
                    size: 22,
                  ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Text(
          tr('language_note'),
          style: almarai(11.5, height: 1.7, color: AppColors.muted),
        ),
      ],
      footer: PrimaryButton(
        label: tr('save'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: () {
          LocaleController.instance.setLanguage(_selected);
          Navigator.of(context).pop();
          showSnack(context, tr('language_changed'));
        },
      ),
    );
  }
}
