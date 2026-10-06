import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Shared by the student and teacher profile screens.
void logOut(BuildContext context) {
  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
}

Future<void> confirmDeleteAccount(BuildContext context) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(tr('delete_account'), style: cairo(16, weight: bold)),
      content: Text(tr('delete_account_body'), style: cairo(13)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(tr('cancel'), style: cairo(13)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(tr('delete'), style: cairo(13, color: AppColors.red)),
        ),
      ],
    ),
  );
  if (ok == true && context.mounted) logOut(context);
}
