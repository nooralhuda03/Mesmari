import 'package:flutter_test/flutter_test.dart';
import 'package:mesmari_shared/features/chat/data/chat_repository.dart';
import 'package:mesmari_shared/features/enrollment/data/enrollment_repository.dart';
import 'package:mesmari_shared/features/notifications/data/notifications_repository.dart';

void main() {
  test('chat keeps sent messages and clears the unread badge', () {
    final chat = ChatRepository.instance;
    chat.seed([
      Conversation(id: 'c1', name: 'نور سالم', subtitle: 'برمجة', unread: 2),
    ]);
    expect(chat.unreadCount, 2);

    chat.send('c1', 'هلا استاذ');
    expect(chat.byId('c1')!.messages.single.text, 'هلا استاذ');
    expect(chat.byId('c1')!.messages.single.mine, isTrue);

    chat.markRead('c1');
    expect(chat.unreadCount, 0);
  });

  test('notifications count only unread items', () {
    final repo = NotificationsRepository.instance;
    repo.seed([
      AppNotification(
        id: '1',
        title: 'أ',
        body: 'ب',
        time: 'الآن',
        kind: NotificationKind.meeting,
      ),
      AppNotification(
        id: '2',
        title: 'ج',
        body: 'د',
        time: 'أمس',
        kind: NotificationKind.message,
        read: true,
      ),
    ]);
    expect(repo.unreadCount, 1);
    repo.markAllRead();
    expect(repo.unreadCount, 0);
  });

  test('only the teacher controls enrolment', () {
    final repo = EnrollmentRepository.instance;
    repo.seed({});
    expect(repo.coursesFor('نور'), isEmpty);

    repo.assign('نور', 'اساسيات البرمجة');
    expect(repo.coursesFor('نور'), ['اساسيات البرمجة']);
    expect(repo.studentsIn('اساسيات البرمجة'), ['نور']);

    repo.unassign('نور', 'اساسيات البرمجة');
    expect(repo.coursesFor('نور'), isEmpty);
  });
}
