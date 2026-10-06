import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';
import 'package:mesmari_shared/features/meetings/data/meeting_link_controller.dart';

/// Schedule a new weekly meeting (teacher).
class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  static const _dayKeys = [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
  ];

  final _title = TextEditingController(text: tr('c_meeting_session'));
  final _link = TextEditingController(
    text: MeetingLinkController.instance.link,
  );
  late final _courses = const CoursesRepository().teacherHomeCourses();
  late String _course = _courses.first.title;
  String _day = 'tuesday';
  TimeOfDay _time = const TimeOfDay(hour: 18, minute: 0);
  int _duration = 60;
  bool _repeat = true;

  @override
  void dispose() {
    _title.dispose();
    _link.dispose();
    super.dispose();
  }

  String get _timeLabel {
    final hour = _time.hourOfPeriod == 0 ? 12 : _time.hourOfPeriod;
    final minute = _time.minute.toString().padLeft(2, '0');
    final period = _time.period == DayPeriod.am ? tr('am') : tr('pm');
    return '$hour:$minute $period';
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _pickCourse() async {
    final choice = await showOptionsSheet(
      context,
      title: tr('choose_course'),
      options: [
        for (final c in _courses)
          SheetOption(Icons.menu_book_outlined, c.title),
      ],
    );
    if (choice != null) setState(() => _course = choice);
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: tr('new_meeting'),
      subtitle: tr('schedule_subtitle'),
      content: [
        LabeledField(label: tr('meeting_title'), controller: _title),
        LabeledField(
          label: tr('meeting_link'),
          controller: _link,
          hint: tr('meeting_link_hint'),
          keyboardType: TextInputType.url,
          textDirection: TextDirection.ltr,
        ),
        Text(
          tr('course'),
          style: almarai(12.25, weight: bold, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        AppCard(
          onTap: _pickCourse,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(_course, style: almarai(13, color: AppColors.text)),
              ),
              Icon(Icons.keyboard_arrow_down, color: AppColors.muted, size: 20),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          tr('day'),
          style: almarai(12.25, weight: bold, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final day in _dayKeys)
              GestureDetector(
                onTap: () => setState(() => _day = day),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _day == day ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    tr(day),
                    style: almarai(
                      11.5,
                      weight: bold,
                      color: _day == day ? Colors.white : AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('start_time'),
                    style: almarai(12.25, weight: bold, color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  AppCard(
                    onTap: _pickTime,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _timeLabel,
                            style: almarai(13, color: AppColors.text),
                          ),
                        ),
                        Icon(Icons.schedule, size: 18, color: AppColors.muted),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('duration'),
                    style: almarai(12.25, weight: bold, color: AppColors.muted),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (final minutes in const [30, 45, 60])
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 5),
                          child: GestureDetector(
                            onTap: () => setState(() => _duration = minutes),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: _duration == minutes
                                    ? AppColors.primary
                                    : AppColors.card,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                '$minutes',
                                textDirection: TextDirection.ltr,
                                style: almarai(
                                  11.5,
                                  weight: bold,
                                  color: _duration == minutes
                                      ? Colors.white
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SwitchTile(
          label: tr('weekly_repeat'),
          subtitle: '${tr('auto_every')} ${tr(_day)}',
          value: _repeat,
          onChanged: (v) => setState(() => _repeat = v),
        ),
      ],
      footer: PrimaryButton(
        label: tr('schedule_meeting_button'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: () {
          MeetingLinkController.instance.setLink(_link.text);
          Navigator.of(context).pop();
          showSnack(
            context,
            '${tr('meeting_scheduled')} ${tr(_day)} $_timeLabel',
          );
        },
      ),
    );
  }
}
