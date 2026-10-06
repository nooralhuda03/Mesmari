import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import '../../data/chat_repository.dart';

/// One conversation.
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    ChatRepository.instance.send(widget.conversationId, text);
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final repo = ChatRepository.instance;
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: repo,
          builder: (context, _) {
            final conversation = repo.byId(widget.conversationId);
            if (conversation == null) {
              return Center(
                child: Text(tr('chat_not_found'), style: almarai(13)),
              );
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border(
                      bottom: BorderSide(color: AppColors.cardBorder),
                    ),
                  ),
                  child: Row(
                    children: [
                      InitialAvatar(
                        conversation.initial,
                        size: 38,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.displayName,
                              style: almarai(
                                14,
                                weight: bold,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              conversation.displaySubtitle,
                              style: almarai(10.5, color: AppColors.muted),
                            ),
                          ],
                        ),
                      ),
                      CircleIconButton(
                        icon: 't_close',
                        iconSize: 13,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    children: [
                      for (final m in conversation.messages)
                        Align(
                          alignment: m.mine
                              ? AlignmentDirectional.centerEnd
                              : AlignmentDirectional.centerStart,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            constraints: const BoxConstraints(maxWidth: 260),
                            decoration: BoxDecoration(
                              color: m.mine
                                  ? AppColors.primary
                                  : AppColors.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: m.mine
                                    ? AppColors.primary
                                    : AppColors.cardBorder,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.displayText,
                                  style: almarai(
                                    12.5,
                                    height: 1.6,
                                    color: m.mine
                                        ? Colors.white
                                        : AppColors.text,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  m.displayTime,
                                  style: almarai(
                                    9.5,
                                    color: m.mine
                                        ? Colors.white70
                                        : const Color(0xFF9A9A9A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  color: AppColors.card,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 44),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                            color: AppColors.bg,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: TextField(
                            controller: _input,
                            style: almarai(13, color: AppColors.text),
                            onSubmitted: (_) => _send(),
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: tr('write_message'),
                              hintStyle: almarai(12.5, color: AppColors.hint),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _send,
                        child: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
