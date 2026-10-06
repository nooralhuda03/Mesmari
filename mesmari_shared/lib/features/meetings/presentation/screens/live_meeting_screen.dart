import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Live meeting room (mock): participants, mic / camera controls and chat.
class LiveMeetingScreen extends StatefulWidget {
  const LiveMeetingScreen({super.key, required this.args});

  final LiveMeetingArgs args;

  @override
  State<LiveMeetingScreen> createState() => _LiveMeetingScreenState();
}

class _LiveMeetingScreenState extends State<LiveMeetingScreen> {
  List<(String, String, bool)> get _others => [
    (tr('c_teacher_sara_plain'), tr('c_i_s'), true),
    (tr('c_student_noor'), tr('c_i_n'), false),
    (tr('c_student_karrar'), tr('c_i_k'), false),
    (tr('c_student_zahraa'), tr('c_i_z'), false),
    (tr('c_student_ahmed'), tr('c_i_a'), false),
  ];

  Timer? _timer;
  int _seconds = 0;
  bool _mic = true;
  bool _camera = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => _seconds++),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _elapsed {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _leave() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          widget.args.isHost ? tr('end_meeting') : tr('leave_meeting'),
          style: cairo(15, weight: bold),
        ),
        content: Text(
          widget.args.isHost
              ? tr('end_meeting_body')
              : tr('leave_meeting_body'),
          style: cairo(13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(tr('cancel'), style: cairo(13)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              widget.args.isHost ? tr('end') : tr('leave'),
              style: cairo(13, color: AppColors.red),
            ),
          ),
        ],
      ),
    );
    if (ok == true && mounted) Navigator.of(context).pop();
  }

  void _openChat() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          18,
          20,
          18 + MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              tr('meeting_chat'),
              style: cairo(15, weight: bold, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            for (final (name, message) in [
              (tr('c_teacher_sara_plain'), tr('c_chat_meeting_1')),
              (tr('c_student_noor'), tr('c_chat_meeting_2')),
              (tr('c_student_karrar'), tr('c_chat_meeting_3')),
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: almarai(
                        11,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(message, style: almarai(12.5, color: AppColors.text)),
                  ],
                ),
              ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: almarai(13),
                    decoration: InputDecoration(
                      hintText: tr('write_message'),
                      hintStyle: almarai(12.5, color: AppColors.hint),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1A1C),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.args.title,
                          overflow: TextOverflow.ellipsis,
                          style: cairo(14, weight: bold, color: Colors.white),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF4D4F),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              tr('live'),
                              style: almarai(10, color: Colors.white70),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _elapsed,
                              textDirection: TextDirection.ltr,
                              style: cairo(10, color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.group_outlined,
                    color: Colors.white70,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${_others.length + 1}',
                    textDirection: TextDirection.ltr,
                    style: cairo(12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.05,
                children: [
                  _tile(tr('you'), tr('c_i_n'), speaking: _mic, isMe: true),
                  for (final (name, initial, speaking) in _others)
                    _tile(name, initial, speaking: speaking),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _control(
                    _mic ? Icons.mic : Icons.mic_off,
                    tr('mic'),
                    active: _mic,
                    onTap: () => setState(() => _mic = !_mic),
                  ),
                  _control(
                    _camera ? Icons.videocam : Icons.videocam_off,
                    tr('camera'),
                    active: _camera,
                    onTap: () => setState(() => _camera = !_camera),
                  ),
                  _control(
                    Icons.chat_bubble_outline,
                    tr('chat_label'),
                    onTap: _openChat,
                  ),
                  _control(
                    Icons.call_end,
                    widget.args.isHost ? tr('end') : tr('leave'),
                    danger: true,
                    onTap: _leave,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    String name,
    String initial, {
    bool speaking = false,
    bool isMe = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF17282B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: speaking ? AppColors.mint : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: InitialAvatar(
              initial,
              size: 54,
              fontSize: 18,
              color: isMe ? AppColors.teal : AppColors.blue,
            ),
          ),
          PositionedDirectional(
            start: 10,
            bottom: 10,
            child: Row(
              children: [
                Icon(
                  speaking ? Icons.mic : Icons.mic_off,
                  size: 13,
                  color: speaking ? AppColors.mint : Colors.white54,
                ),
                const SizedBox(width: 5),
                Text(name, style: almarai(10.5, color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _control(
    IconData icon,
    String label, {
    bool active = false,
    bool danger = false,
    required VoidCallback onTap,
  }) {
    final background = danger
        ? const Color(0xFFE5484D)
        : active
        ? AppColors.teal
        : const Color(0xFF1D3033);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: almarai(10, color: Colors.white70)),
        ],
      ),
    );
  }
}
