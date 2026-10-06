import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';
import 'package:mesmari_shared/features/meetings/data/meeting_link_controller.dart';
import 'package:mesmari_shared/features/profile/data/profile_controller.dart';
import 'package:mesmari_shared/features/chat/presentation/widgets/chat_button.dart';
import 'package:mesmari_shared/features/notifications/presentation/widgets/notification_bell.dart';

/// Figma 171 — teacher home.
class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: AppColors.card,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 14, 16, 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.profile),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const SvgIcon('t_avatar_bg', size: 44.37),
                                ListenableBuilder(
                                  listenable: ProfileController.instance,
                                  builder: (context, _) => Text(
                                    ProfileController.instance.profile.initials,
                                    style: almarai(
                                      12,
                                      weight: bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ListenableBuilder(
                          listenable: ProfileController.instance,
                          builder: (context, _) => Text(
                            ProfileController.instance.profile.displayName,
                            style: almarai(
                              16,
                              weight: bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const NotificationBell(size: 34),
                        const SizedBox(width: 8),
                        const ChatButton(size: 34),
                      ],
                    ),
                    const SizedBox(height: 11),
                    _MeetingCard(onStart: () => openMeetingLink(context)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 4),
                      child: Text(
                        tr('my_courses'),
                        style: almarai(
                          16,
                          weight: extraBold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => onNavigate(1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 4),
                        child: Text(
                          tr('view_all'),
                          style: almarai(
                            12,
                            weight: bold,
                            color: const Color(0xFFADADAD),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                for (final c in const CoursesRepository().teacherHomeCourses())
                  _CourseRow(
                    course: c,
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.courseManage, arguments: c.id),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeetingCard extends StatelessWidget {
  const _MeetingCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.26, 0.9],
          colors: [Color(0xFF164A4A), Color(0xFF277870)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('next_meeting'), style: almarai(11.76, color: Colors.white)),
          const SizedBox(height: 6),
          Text(
            tr('c_meeting_card'),
            style: almarai(16.66, weight: extraBold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            tr('c_meeting_18_registered'),
            style: almarai(11, color: const Color(0xFFDADADA)),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onStart,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 11),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tr('start_meeting'),
                style: tajawal(13, weight: extraBold, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseRow extends StatelessWidget {
  const _CourseRow({required this.course, required this.onTap});

  final TeacherCourse course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SvgIcon('edit_white', size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: almarai(13.5, weight: bold, color: AppColors.text),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${course.students} ${tr('students_word')} · ${tr('avg_completion')} ${course.completion}٪',
                    style: almarai(11.5, color: AppColors.muted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const SvgIcon('t_chevron', size: 13),
          ],
        ),
      ),
    );
  }
}
