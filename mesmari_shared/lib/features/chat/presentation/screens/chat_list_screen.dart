import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import '../../data/chat_repository.dart';

/// List of conversations (teacher <-> student).
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = ChatRepository.instance;
    return ListenableBuilder(
      listenable: repo,
      builder: (context, _) {
        final conversations = repo.conversations;
        return AppScreen(
          title: tr('chats'),
          subtitle: AppFlavor.isTeacher
              ? tr('chats_with_students')
              : tr('chats_with_teachers'),
          content: [
            if (conversations.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  tr('no_chats'),
                  textAlign: TextAlign.center,
                  style: almarai(13, color: AppColors.muted),
                ),
              ),
            for (final c in conversations)
              AppCard(
                onTap: () {
                  repo.markRead(c.id);
                  Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.chat, arguments: c.id);
                },
                child: Row(
                  children: [
                    InitialAvatar(
                      c.initial,
                      size: 42,
                      fontSize: 16,
                      color: AppFlavor.isTeacher
                          ? AppColors.blue
                          : AppColors.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  c.displayName,
                                  style: almarai(
                                    13.5,
                                    weight: bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              if (c.last != null)
                                Text(
                                  c.last!.displayTime,
                                  style: almarai(
                                    10,
                                    color: const Color(0xFF9A9A9A),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  c.last?.displayText ?? c.displaySubtitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: almarai(11.5, color: AppColors.muted),
                                ),
                              ),
                              if (c.unread > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  height: 18,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${c.unread}',
                                    textDirection: TextDirection.ltr,
                                    style: cairo(
                                      9.5,
                                      weight: bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
