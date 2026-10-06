import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/chat/data/chat_repository.dart';
import 'package:mesmari_shared/features/enrollment/data/enrollment_repository.dart';
import 'package:mesmari_shared/features/notifications/data/notifications_repository.dart';

import 'app/app.dart';
import 'app/seed_data.dart';

void main() {
  AppFlavor.isTeacher = true;
  NotificationsRepository.instance.seed(teacherNotifications());
  ChatRepository.instance.seed(teacherConversations());
  EnrollmentRepository.instance.seed(teacherEnrollments());
  if (kDebugMode) {
    final lang = Uri.base.queryParameters['lang'];
    if (lang != null) LocaleController.instance.setLanguage(lang);
    final theme = Uri.base.queryParameters['theme'];
    if (theme == 'dark') {
      ThemeController.instance.setMode(ThemeMode.dark);
    } else if (theme == 'light') {
      ThemeController.instance.setMode(ThemeMode.light);
    }
  }
  runApp(const TeacherApp());
}
