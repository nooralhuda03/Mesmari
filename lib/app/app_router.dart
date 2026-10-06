import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/auth/presentation/screens/otp_screen.dart';
import 'package:mesmari_shared/features/auth/presentation/screens/login_screen.dart';
import 'package:mesmari_shared/features/auth/presentation/screens/signup_screen.dart';
import 'package:mesmari_shared/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:mesmari_shared/features/chat/presentation/screens/chat_screen.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';
import 'package:mesmari_shared/features/media/presentation/screens/pdf_viewer_screen.dart';
import 'package:mesmari_shared/features/media/presentation/screens/video_player_screen.dart';
import 'package:mesmari_shared/features/meetings/presentation/screens/live_meeting_screen.dart';
import 'package:mesmari_shared/features/notifications/presentation/screens/notification_center_screen.dart';
import 'package:mesmari_shared/features/notifications/presentation/screens/notification_settings_screen.dart';
import 'package:mesmari_shared/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mesmari_shared/features/profile/presentation/screens/appearance_screen.dart';
import 'package:mesmari_shared/features/profile/presentation/screens/language_screen.dart';

import '../features/certificates/presentation/screens/reports_screen.dart';
import '../features/courses/presentation/screens/assign_course_screen.dart';
import '../features/courses/presentation/screens/course_manage_screen.dart';
import '../features/courses/presentation/screens/lecture_edit_screen.dart';
import '../features/courses/presentation/screens/new_course_screen.dart';
import '../features/meetings/presentation/screens/schedule_meeting_screen.dart';
import '../features/meetings/presentation/screens/teacher_meetings_screen.dart';
import '../features/profile/presentation/screens/earnings_screen.dart';
import '../features/profile/presentation/screens/teacher_profile_screen.dart';
import '../features/quiz/presentation/screens/quiz_editor_screen.dart';
import '../features/students/presentation/screens/send_reminder_screen.dart';
import 'teacher_shell.dart';

/// Routes of the teacher app.
abstract final class TeacherRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      // Rebuilt when the language changes so the page picks up the new text.
      builder: (_) => ListenableBuilder(
        listenable: Listenable.merge([
          LocaleController.instance,
          ThemeController.instance,
        ]),
        builder: (context, _) => _pageFor(settings),
      ),
    );
  }

  static Widget _pageFor(RouteSettings settings) {
    final args = settings.arguments;
    return switch (settings.name) {
      AppRoutes.otp => OtpScreen(
        phone: args is OtpArgs ? args.phone : '07XXXXXXXXX',
      ),
      AppRoutes.signup => const SignupScreen(),
      AppRoutes.home => TeacherShell(initialIndex: args is int ? args : 0),
      AppRoutes.courseManage => CourseManageScreen(
        courseId: args is String ? args : 'basics',
      ),
      AppRoutes.newCourse => const NewCourseScreen(),
      AppRoutes.assignCourse => AssignCourseScreen(
        courseId: args is String ? args : 'basics',
      ),
      AppRoutes.lectureEdit => LectureEditScreen(
        lecture: args is ManagedLecture ? args : null,
      ),
      AppRoutes.quizEditor => QuizEditorScreen(
        lectureTitle: args is String ? args : tr('c_lecture_loops'),
      ),
      AppRoutes.teacherMeetings => const TeacherMeetingsScreen(),
      AppRoutes.scheduleMeeting => const ScheduleMeetingScreen(),
      AppRoutes.reports => const ReportsScreen(),
      AppRoutes.earnings => const EarningsScreen(),
      AppRoutes.sendReminder => SendReminderScreen(
        studentName: args is String ? args : tr('student'),
      ),
      AppRoutes.profile => const TeacherProfileScreen(),
      AppRoutes.editProfile => const EditProfileScreen(),
      AppRoutes.notificationCenter => const NotificationCenterScreen(),
      AppRoutes.notificationSettings => const NotificationSettingsScreen(),
      AppRoutes.language => const LanguageScreen(),
      AppRoutes.appearance => const AppearanceScreen(),
      AppRoutes.chatList => const ChatListScreen(),
      AppRoutes.chat => ChatScreen(
        conversationId: args is String ? args : 's-mustafa',
      ),
      AppRoutes.liveMeeting => LiveMeetingScreen(
        args: args is LiveMeetingArgs
            ? args
            : LiveMeetingArgs(title: tr('c_meeting_live_short'), isHost: true),
      ),
      AppRoutes.videoPlayer => VideoPlayerScreen(
        args: args is PlayerArgs
            ? args
            : PlayerArgs(title: tr('c_meeting_recording')),
      ),
      AppRoutes.pdfViewer => PdfViewerScreen(
        args: args is DocArgs ? args : DocArgs(title: tr('c_file')),
      ),
      _ => const LoginScreen(),
    };
  }
}
