import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';

class SheetOption {
  const SheetOption(this.icon, this.label);

  final IconData icon;
  final String label;
}

/// Bottom sheet with a title and a list of choices; returns the chosen label.
Future<String?> showOptionsSheet(
  BuildContext context, {
  required String title,
  required List<SheetOption> options,
}) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 6),
            child: Text(
              title,
              style: cairo(15, weight: bold, color: AppColors.primary),
            ),
          ),
          for (final option in options)
            ListTile(
              leading: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(option.icon, size: 18, color: AppColors.primary),
              ),
              title: Text(option.label, style: almarai(13)),
              onTap: () => Navigator.pop(ctx, option.label),
            ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
