import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Compose a reminder for a student who is falling behind.
class SendReminderScreen extends StatefulWidget {
  const SendReminderScreen({super.key, required this.studentName});

  final String studentName;

  @override
  State<SendReminderScreen> createState() => _SendReminderScreenState();
}

class _SendReminderScreenState extends State<SendReminderScreen> {
  late final _templates = <String, String>{
    'gentle_reminder':
        'مرحبا ${widget.studentName}، تذكير بسيط اكو محاضرات بانتظارك بكورس اساسيات البرمجة.',
    'progress_followup':
        'مرحبا ${widget.studentName}، شفت تقدمك بالكورس وحاب اعرف اذا تحتاج مساعدة بأي محاضرة.',
    'meeting_invite':
        'مرحبا ${widget.studentName}، لا تفوت الاجتماع المباشر هذا الاسبوع، راح نراجع الاسئلة سوية.',
  };

  late String _selected = _templates.keys.first;
  late final _message = TextEditingController(text: _templates.values.first);
  bool _alsoNotify = true;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: tr('send_reminder'),
      subtitle: tr('private_message'),
      content: [
        AppCard(
          child: Row(
            children: [
              InitialAvatar(
                widget.studentName.characters.first,
                size: 40,
                fontSize: 15,
                color: AppColors.blue,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.studentName,
                      style: almarai(
                        13,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      tr('behind_class'),
                      style: almarai(11, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          tr('templates'),
          style: almarai(12.25, weight: bold, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final template in _templates.keys)
              GestureDetector(
                onTap: () => setState(() {
                  _selected = template;
                  _message.text = _templates[template]!;
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _selected == template
                        ? AppColors.primary
                        : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    tr(template),
                    style: almarai(
                      11.5,
                      weight: bold,
                      color: _selected == template
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        LabeledField(
          label: tr('message_text'),
          controller: _message,
          maxLines: 5,
        ),
        SwitchTile(
          label: tr('send_in_app'),
          subtitle: tr('besides_sms'),
          value: _alsoNotify,
          onChanged: (v) => setState(() => _alsoNotify = v),
        ),
      ],
      footer: PrimaryButton(
        label: tr('send_reminder_button'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: () {
          Navigator.of(context).pop();
          showSnack(context, '${tr('reminder_sent')} ${widget.studentName}');
        },
      ),
    );
  }
}
