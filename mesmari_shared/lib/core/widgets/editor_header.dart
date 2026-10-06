import 'package:flutter/material.dart';

import 'package:mesmari_shared/core/theme/app_colors.dart';
import 'package:mesmari_shared/core/theme/app_text.dart';
import 'package:mesmari_shared/core/widgets/circle_icon_button.dart';

/// Title on the start side with a close button on the end side
/// (used by the teacher edit screens).
class EditorHeader extends StatelessWidget {
  const EditorHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: almarai(16, weight: extraBold, color: AppColors.primary),
          ),
        ),
        CircleIconButton(
          icon: 't_close',
          iconSize: 13,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
