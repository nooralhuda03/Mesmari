import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import '../../data/chat_repository.dart';

/// Chat icon with an unread badge, for the home headers.
class ChatButton extends StatelessWidget {
  const ChatButton({super.key, this.size = 36});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ChatRepository.instance,
      builder: (context, _) {
        final count = ChatRepository.instance.unreadCount;
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.chatList),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 17,
                  color: AppColors.primary,
                ),
              ),
              if (count > 0)
                PositionedDirectional(
                  top: -2,
                  end: -2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    constraints: const BoxConstraints(minWidth: 17),
                    height: 17,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5484D),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.card, width: 1.5),
                    ),
                    child: Text(
                      '$count',
                      textDirection: TextDirection.ltr,
                      style: cairo(9, weight: bold, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
