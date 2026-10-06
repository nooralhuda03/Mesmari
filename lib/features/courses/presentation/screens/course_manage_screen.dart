import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';

/// Figma 173 — manage a course's lectures.
/// Tap the pencil to edit a lecture, tap the row to edit its quiz.
class CourseManageScreen extends StatelessWidget {
  const CourseManageScreen({super.key, required this.courseId});

  /// Stable course id.
  final String courseId;

  @override
  Widget build(BuildContext context) {
    final title =
        const CoursesRepository().courseById(courseId)?.title ?? courseId;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
          children: [
            Text(
              title,
              style: almarai(20, weight: extraBold, color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Text(
                  tr('manage_content'),
                  style: almarai(13, color: const Color(0xFF909090)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: Pill(
                    tr('published'),
                    width: 73,
                    padding: EdgeInsets.zero,
                    textStyle: almarai(
                      13,
                      weight: bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: '+     ${tr('add_lecture')}',
              height: 43,
              radius: 10,
              style: almarai(15, weight: bold, color: Colors.white),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.lectureEdit),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: tr('course_students'),
              height: 43,
              radius: 10,
              color: AppColors.mint,
              style: almarai(15, weight: bold, color: AppColors.primary),
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.assignCourse, arguments: courseId),
            ),
            const SizedBox(height: 20),
            Text(
              tr('lectures'),
              style: almarai(15, weight: bold, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            for (final l in const CoursesRepository().managedLectures())
              _ManagedLectureRow(
                lecture: l,
                onEdit: () => Navigator.of(
                  context,
                ).pushNamed(AppRoutes.lectureEdit, arguments: l),
                onOpen: () => Navigator.of(
                  context,
                ).pushNamed(AppRoutes.quizEditor, arguments: l.title),
              ),
          ],
        ),
      ),
    );
  }
}

class _ManagedLectureRow extends StatelessWidget {
  const _ManagedLectureRow({
    required this.lecture,
    required this.onEdit,
    required this.onOpen,
  });

  final ManagedLecture lecture;
  final VoidCallback onEdit;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: Container(
        height: 57,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsetsDirectional.only(start: 11, end: 8),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.tileBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 33,
              height: 33,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.mint,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${lecture.number}',
                style: almarai(15, weight: bold, color: AppColors.primary),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                lecture.title,
                overflow: TextOverflow.ellipsis,
                style: almarai(13, weight: bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onEdit,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 2),
                    child: SizedBox(
                      width: 12.7,
                      height: 12.7,
                      child: Stack(
                        textDirection: TextDirection.ltr,
                        children: const [
                          SvgIcon('pencil_a', width: 12.7, height: 12.69),
                          Positioned(
                            left: 6,
                            top: 1.9,
                            child: SvgIcon(
                              'pencil_b',
                              width: 4.89,
                              height: 4.9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  '${tr('lecture')} ${lecture.number} . ${lecture.minutes} ${tr('minute')}',
                  style: almarai(11, color: const Color(0xFF6C6C6C)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
