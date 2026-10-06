import 'package:flutter/foundation.dart';

import 'package:mesmari_shared/core/l10n/app_strings.dart';

@immutable
class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.time,
    required this.mine,
  });

  final String text;
  final String time;

  /// Seeded messages hold a translation key; text typed by the user
  /// passes through unchanged.
  String get displayText => tr(text);

  String get displayTime => tr(time);

  /// True when the signed-in user sent it.
  final bool mine;
}

class Conversation {
  Conversation({
    required this.id,
    required this.name,
    required this.subtitle,
    List<ChatMessage>? messages,
    this.unread = 0,
  }) : messages = messages ?? [];

  final String id;
  final String name;

  /// Course name, or the teacher's title.
  final String subtitle;
  final List<ChatMessage> messages;
  int unread;

  /// Display name — seeded entries hold a translation key.
  String get displayName => tr(name);

  String get displaySubtitle => tr(subtitle);

  String get initial =>
      displayName.trim().isEmpty ? '؟' : displayName.trim().substring(0, 1);

  ChatMessage? get last => messages.isEmpty ? null : messages.last;
}

/// Chat between a teacher and a student. Each app seeds it in `main()`.
class ChatRepository extends ChangeNotifier {
  ChatRepository._();

  static final ChatRepository instance = ChatRepository._();

  final List<Conversation> _conversations = [];

  List<Conversation> get conversations => List.unmodifiable(_conversations);

  int get unreadCount => _conversations.fold(0, (sum, c) => sum + c.unread);

  void seed(List<Conversation> items) {
    _conversations
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  Conversation? byId(String id) {
    for (final c in _conversations) {
      if (c.id == id) return c;
    }
    return null;
  }

  void send(String id, String text) {
    final conversation = byId(id);
    if (conversation == null || text.trim().isEmpty) return;
    conversation.messages.add(
      ChatMessage(text: text.trim(), time: tr('c_time_now'), mine: true),
    );
    notifyListeners();
  }

  void markRead(String id) {
    byId(id)?.unread = 0;
    notifyListeners();
  }
}
