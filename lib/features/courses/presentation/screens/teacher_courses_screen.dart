import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';

/// Figma 172 — teacher's course list.
class TeacherCoursesScreen extends StatelessWidget {
  const TeacherCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Text(
                  tr('my_courses'),
                  style: almarai(
                    20,
                    weight: extraBold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.newCourse),
                child: Pill(
                  '+ ${tr('new_course')}',
                  width: 116,
                  height: 34,
                  color: AppColors.primary,
                  padding: EdgeInsets.zero,
                  textStyle: almarai(12, weight: bold, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          for (final c in const CoursesRepository().teacherCourses())
            _TeacherCourseCard(
              course: c,
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.courseManage, arguments: c.id),
            ),
        ],
      ),
    );
  }
}

class _TeacherCourseCard extends StatelessWidget {
  const _TeacherCourseCard({required this.course, required this.onTap});

  final TeacherCourse course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsetsDirectional.fromSTEB(21, 15, 15, 15),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    tr('programming'),
                    style: almarai(
                      15,
                      weight: bold,
                      color: const Color(0xFF7B7B7B),
                    ),
                  ),
                ),
                const Spacer(),
                Pill(
                  tr('active'),
                  width: 73,
                  padding: EdgeInsets.zero,
                  textStyle: almarai(
                    13,
                    weight: bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(course.title, style: almarai(16, weight: bold)),
            const SizedBox(height: 12),
            Text(
              '${course.students} ${tr('students_word')} . ${course.lectures} ${tr('lecture_word')}',
              style: almarai(12, color: const Color(0xFF7C7C7C)),
            ),
            const SizedBox(height: 11),
            Text(
              tr('avg_completion'),
              style: almarai(11, color: const Color(0xFF8D8D8D)),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  '${course.completion} %',
                  textDirection: TextDirection.ltr,
                  style: almarai(11, weight: bold, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 7),
              child: ProgressLine(value: course.completion / 100),
            ),
          ],
        ),
      ),
    );
  }
}
