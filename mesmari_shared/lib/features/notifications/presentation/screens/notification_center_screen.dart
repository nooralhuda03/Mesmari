import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import '../../data/notifications_repository.dart';

/// The in-app notification list.
class NotificationCenterScreen extends StatelessWidget {
  const NotificationCenterScreen({super.key});

  static IconData _icon(NotificationKind kind) => switch (kind) {
    NotificationKind.meeting => Icons.videocam_outlined,
    NotificationKind.lecture => Icons.play_circle_outline,
    NotificationKind.message => Icons.chat_bubble_outline,
    NotificationKind.course => Icons.menu_book_outlined,
    NotificationKind.certificate => Icons.workspace_premium_outlined,
    NotificationKind.reminder => Icons.notifications_active_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final repo = NotificationsRepository.instance;
    return ListenableBuilder(
      listenable: repo,
      builder: (context, _) {
        final items = repo.items;
        return AppScreen(
          title: tr('notifications'),
          subtitle: repo.unreadCount == 0
              ? tr('no_new_notifications')
              : '${repo.unreadCount} ${tr('new_notifications')}',
          content: [
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      size: 40,
                      color: AppColors.border,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      tr('no_notifications'),
                      style: almarai(13, color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            for (final n in items)
              AppCard(
                color: n.read ? AppColors.card : AppColors.surface,
                onTap: () => repo.markRead(n.id),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: n.read ? AppColors.surfaceAlt : AppColors.mint,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _icon(n.kind),
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  n.displayTitle,
                                  style: almarai(
                                    13,
                                    weight: bold,
                                    color: AppColors.text,
                                  ),
                                ),
                              ),
                              if (!n.read)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.teal,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            n.displayBody,
                            style: almarai(
                              11.5,
                              height: 1.6,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            n.displayTime,
                            style: almarai(10, color: const Color(0xFF9A9A9A)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
          footer: items.isEmpty
              ? null
              : PrimaryButton(
                  label: tr('mark_all_read'),
                  height: 46,
                  radius: 10,
                  color: AppColors.card,
                  style: almarai(13, weight: bold, color: AppColors.primary),
                  onTap: repo.markAllRead,
                ),
        );
      },
    );
  }
}
