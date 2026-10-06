import 'package:flutter/foundation.dart';

import 'package:mesmari_shared/core/l10n/app_strings.dart';

enum NotificationKind {
  meeting,
  lecture,
  message,
  course,
  certificate,
  reminder,
}

class AppNotification {
  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.kind,
    this.read = false,
  });

  final String id;
  final String title;
  final String body;
  final String time;
  final NotificationKind kind;
  bool read;

  /// Seeded entries hold translation keys.
  String get displayTitle => tr(title);

  String get displayBody => tr(body);

  String get displayTime => tr(time);
}

/// In-app notification centre. Each app seeds it in `main()`.
class NotificationsRepository extends ChangeNotifier {
  NotificationsRepository._();

  static final NotificationsRepository instance = NotificationsRepository._();

  final List<AppNotification> _items = [];

  List<AppNotification> get items => List.unmodifiable(_items);

  int get unreadCount => _items.where((n) => !n.read).length;

  void seed(List<AppNotification> items) {
    _items
      ..clear()
      ..addAll(items);
    notifyListeners();
  }

  void add(AppNotification item) {
    _items.insert(0, item);
    notifyListeners();
  }

  void markRead(String id) {
    for (final n in _items.where((n) => n.id == id)) {
      n.read = true;
    }
    notifyListeners();
  }

  void markAllRead() {
    for (final n in _items) {
      n.read = true;
    }
    notifyListeners();
  }
}
