import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Notification preferences.
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late final Map<String, bool> _topics = {
    if (AppFlavor.isTeacher) ...{
      'new_student_questions': true,
      'new_enrollment': true,
      'weekly_meeting_reminder': true,
      'weekly_report': false,
    } else ...{
      'weekly_meeting_reminder': true,
      'new_lectures': true,
      'teacher_replied': true,
      'classmates_progress': false,
    },
  };

  final Map<String, bool> _channels = {
    'in_app_notifications': true,
    'sms': false,
    'email_channel': false,
  };

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: tr('notification_settings'),
      subtitle: tr('choose_notifications'),
      content: [
        SectionTitle(tr('notification_type')),
        for (final entry in _topics.entries)
          SwitchTile(
            label: tr(entry.key),
            value: entry.value,
            onChanged: (v) => setState(() => _topics[entry.key] = v),
          ),
        const SizedBox(height: 16),
        SectionTitle(tr('delivery_method')),
        for (final entry in _channels.entries)
          SwitchTile(
            label: tr(entry.key),
            value: entry.value,
            onChanged: (v) => setState(() => _channels[entry.key] = v),
          ),
        const SizedBox(height: 16),
        SectionTitle(tr('quiet_hours')),
        AppCard(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  tr('quiet_hours_text'),
                  style: almarai(12.5, color: AppColors.muted),
                ),
              ),
              Icon(
                Icons.nightlight_outlined,
                size: 18,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
      footer: PrimaryButton(
        label: tr('save_settings'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: () {
          Navigator.of(context).pop();
          showSnack(context, tr('notification_settings_saved'));
        },
      ),
    );
  }
}
