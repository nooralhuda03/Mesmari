import 'package:mesmari_shared/features/chat/data/chat_repository.dart';
import 'package:mesmari_shared/features/notifications/data/notifications_repository.dart';

/// Sample content for the teacher app. Replace with API data later.
List<AppNotification> teacherNotifications() => [
  AppNotification(
    id: 'n1',
    title: 'c_notif_question_title',
    body: 'c_notif_question_body',
    time: 'c_time_15min',
    kind: NotificationKind.message,
  ),
  AppNotification(
    id: 'n2',
    title: 'c_notif_meeting2_title',
    body: 'c_notif_meeting2_body',
    time: 'c_time_1h',
    kind: NotificationKind.meeting,
  ),
  AppNotification(
    id: 'n3',
    title: 'c_notif_behind_title',
    body: 'c_notif_behind_body',
    time: 'c_time_yesterday',
    kind: NotificationKind.reminder,
  ),
  AppNotification(
    id: 'n4',
    title: 'c_notif_cert_title',
    body: 'c_notif_cert_body',
    time: 'c_time_2d',
    kind: NotificationKind.certificate,
    read: true,
  ),
];

List<Conversation> teacherConversations() => [
  Conversation(
    id: 's-mustafa',
    name: 'c_student_mustafa',
    subtitle: 'c_course_basics',
    unread: 2,
    messages: const [
      ChatMessage(text: 'c_chat_mustafa_1', time: 'c_time_1002', mine: false),
      ChatMessage(text: 'c_chat_mustafa_2', time: 'c_time_1003', mine: false),
    ],
  ),
  Conversation(
    id: 's-zahraa',
    name: 'c_student_zahraa',
    subtitle: 'c_course_web',
    unread: 1,
    messages: const [
      ChatMessage(
        text: 'c_chat_zahraa_1',
        time: 'c_time_yesterday',
        mine: false,
      ),
    ],
  ),
  Conversation(
    id: 's-noor',
    name: 'c_student_noor',
    subtitle: 'c_course_basics',
    messages: const [
      ChatMessage(text: 'c_chat_noor_1', time: 'c_time_yesterday', mine: false),
      ChatMessage(
        text: 'c_chat_me_reply',
        time: 'c_time_yesterday',
        mine: true,
      ),
    ],
  ),
  Conversation(
    id: 's-heba',
    name: 'c_student_heba',
    subtitle: 'c_course_basics',
    messages: const [
      ChatMessage(text: 'c_chat_heba_1', time: 'c_time_2d', mine: false),
    ],
  ),
];

/// Who is enrolled in what. The teacher controls this.
Map<String, Set<String>> teacherEnrollments() => {
  'noor': {'basics'},
  'karrar': {'basics', 'web'},
  'ahmed': {'basics'},
  'zahraa': {'web'},
  'mustafa': {'basics'},
  'heba': {'basics'},
};
