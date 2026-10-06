import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import 'package:mesmari_shared/features/courses/data/courses_repository.dart';

/// Create a new course (teacher).
class NewCourseScreen extends StatefulWidget {
  const NewCourseScreen({super.key});

  @override
  State<NewCourseScreen> createState() => _NewCourseScreenState();
}

class _NewCourseScreenState extends State<NewCourseScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _lectures = TextEditingController(text: '12');

  late final _categories = const CoursesRepository().categories().sublist(1);
  late String _category = _categories.first;
  Color _color = AppColors.teal;
  bool _liveMeeting = true;

  static final _colors = [
    AppColors.teal,
    AppColors.primary,
    AppColors.blue,
    AppColors.deepTeal,
  ];

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _lectures.dispose();
    super.dispose();
  }

  void _publish() {
    if (_title.text.trim().isEmpty) {
      showSnack(context, tr('write_course_title'));
      return;
    }
    Navigator.of(context).pop();
    showSnack(context, '${tr('course_published')} ${_title.text.trim()}');
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: tr('new_course'),
      subtitle: tr('new_course_subtitle'),
      content: [
        Container(
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0x26004957)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 52,
                color: _color,
                alignment: Alignment.center,
                child: Text(
                  _category,
                  style: almarai(17, weight: bold, color: AppColors.bg),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title.text.trim().isEmpty
                          ? tr('course_title')
                          : _title.text.trim(),
                      style: almarai(14, weight: bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tr('course_preview_hint'),
                      style: almarai(11, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        LabeledField(
          label: tr('course_title'),
          controller: _title,
          hint: tr('course_title_hint'),
          onChanged: (_) => setState(() {}),
        ),
        Text(
          tr('category'),
          style: almarai(12.25, weight: bold, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final category in _categories)
              GestureDetector(
                onTap: () => setState(() => _category = category),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _category == category
                        ? AppColors.primary
                        : AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    category,
                    style: almarai(
                      11.5,
                      weight: bold,
                      color: _category == category
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          tr('cover_color'),
          style: almarai(12.25, weight: bold, color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final color in _colors)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: GestureDetector(
                  onTap: () => setState(() => _color = color),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _color == color
                            ? AppColors.text
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        LabeledField(
          label: tr('course_description'),
          controller: _description,
          maxLines: 4,
          hint: tr('course_desc_hint'),
        ),
        LabeledField(
          label: tr('lectures_count'),
          controller: _lectures,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
        ),
        SwitchTile(
          label: tr('weekly_live_meeting'),
          subtitle: tr('weekly_qa'),
          value: _liveMeeting,
          onChanged: (v) => setState(() => _liveMeeting = v),
        ),
      ],
      footer: PrimaryButton(
        label: tr('publish_course'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: _publish,
      ),
    );
  }
}
