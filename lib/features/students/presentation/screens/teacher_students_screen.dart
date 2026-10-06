import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_teacher/features/students/data/students_repository.dart';

/// Figma 176 — student progress tracking.
class TeacherStudentsScreen extends StatelessWidget {
  const TeacherStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: AppColors.card,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('track_students'),
                    style: almarai(
                      20,
                      weight: extraBold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 11),
                  Text(
                    tr('c_course_basics'),
                    style: almarai(13, color: const Color(0xFF909090)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: _Stat(tr('c_student_noor'), tr('top_progress')),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: _Stat('56 %', tr('avg_progress'))),
                    SizedBox(width: 10),
                    Expanded(child: _Stat('24', tr('students_word'))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                tr('students_by_progress'),
                style: almarai(16, weight: bold, color: AppColors.primary),
              ),
              const SizedBox(height: 19),
              Container(
                padding: const EdgeInsets.fromLTRB(19, 19, 19, 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFD6D6D6)),
                ),
                child: Column(
                  children: [
                    for (final s in const StudentsRepository().progress())
                      _StudentRow(student: s),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E3E3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: almarai(14, weight: bold)),
          const SizedBox(height: 6),
          Text(label, style: almarai(10, color: const Color(0xFF7E7E7E))),
        ],
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow({required this.student});

  final StudentProgress student;

  @override
  Widget build(BuildContext context) {
    final percent = '${(student.progress * 100).round()} %';
    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.only(start: 17, end: 13),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8.75),
        border: Border.all(color: const Color(0xFFE2E2E2), width: 0.875),
      ),
      child: Row(
        children: [
          InitialAvatar(student.initial, size: 32, color: student.color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      student.name,
                      style: almarai(
                        12,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),
                    if (student.needsReminder)
                      _ReminderChip(name: student.name)
                    else
                      Text(
                        percent,
                        textDirection: TextDirection.ltr,
                        style: almarai(
                          12,
                          weight: bold,
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: ProgressLine(
                    value: student.progress,
                    color: student.needsReminder
                        ? AppColors.red
                        : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderChip extends StatelessWidget {
  const _ReminderChip({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(AppRoutes.sendReminder, arguments: name.trim()),
      child: Container(
        width: 54,
        height: 19,
        decoration: BoxDecoration(
          color: const Color(0xFFFCE1DE),
          borderRadius: BorderRadius.circular(12.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgIcon('notif_red', size: 10),
            const SizedBox(width: 3),
            Text(
              tr('remind'),
              style: almarai(8, weight: bold, color: const Color(0xFFFF0000)),
            ),
          ],
        ),
      ),
    );
  }
}
