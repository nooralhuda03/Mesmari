import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/chat/data/chat_repository.dart';
import 'package:mesmari_shared/features/enrollment/data/enrollment_repository.dart';
import 'package:mesmari_teacher/app/seed_data.dart';
import 'package:mesmari_teacher/app/app.dart';

const _routes = [
  AppRoutes.login,
  AppRoutes.otp,
  AppRoutes.home,
  AppRoutes.courseManage,
  AppRoutes.newCourse,
  AppRoutes.assignCourse,
  AppRoutes.lectureEdit,
  AppRoutes.quizEditor,
  AppRoutes.teacherMeetings,
  AppRoutes.scheduleMeeting,
  AppRoutes.reports,
  AppRoutes.earnings,
  AppRoutes.sendReminder,
  AppRoutes.profile,
  AppRoutes.editProfile,
  AppRoutes.notificationCenter,
  AppRoutes.notificationSettings,
  AppRoutes.language,
  AppRoutes.chatList,
  AppRoutes.chat,
  AppRoutes.liveMeeting,
  AppRoutes.videoPlayer,
  AppRoutes.pdfViewer,
];

Widget _app(RouteSettings settings) => TeacherApp(initialSettings: settings);

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    AppFlavor.isTeacher = true;
  });

  setUp(() {
    ChatRepository.instance.seed(teacherConversations());
    EnrollmentRepository.instance.seed(teacherEnrollments());
  });

  for (final route in _routes) {
    testWidgets('teacher route $route builds', (tester) async {
      await tester.pumpWidget(_app(RouteSettings(name: route)));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the teacher assigns a course to a student', (tester) async {
    final repo = EnrollmentRepository.instance;
    expect(repo.isAssigned('zahraa', 'basics'), isFalse);

    await tester.pumpWidget(
      _app(
        const RouteSettings(name: AppRoutes.assignCourse, arguments: 'basics'),
      ),
    );
    await tester.pump();

    final row = find.ancestor(
      of: find.text('زهراء علي'),
      matching: find.byType(Row),
    );
    await tester.tap(
      find.descendant(of: row.first, matching: find.byType(Switch)),
    );
    await tester.pump();

    expect(repo.isAssigned('zahraa', 'basics'), isTrue);
  });
}
