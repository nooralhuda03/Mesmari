import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_teacher/features/questions/data/questions_repository.dart';

/// Figma 177 — student questions inbox with reply.
class TeacherQuestionsScreen extends StatefulWidget {
  const TeacherQuestionsScreen({super.key});

  @override
  State<TeacherQuestionsScreen> createState() => _TeacherQuestionsScreenState();
}

class _TeacherQuestionsScreenState extends State<TeacherQuestionsScreen> {
  final _questions = const QuestionsRepository().questions();
  bool _unansweredOnly = true;

  Future<void> _reply(StudentQuestion q) async {
    await Navigator.of(
      context,
    ).pushNamed(AppRoutes.chat, arguments: 's-${q.id}');
    if (mounted) setState(() => q.answered = true);
  }

  @override
  Widget build(BuildContext context) {
    final unanswered = _questions.where((q) => !q.answered).length;
    final visible = _unansweredOnly
        ? _questions.where((q) => !q.answered).toList()
        : _questions;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 16),
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8),
            child: Text(
              tr('questions_and_chats'),
              style: almarai(20, weight: extraBold, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _filter(
                tr('all_questions'),
                !_unansweredOnly,
                () => setState(() => _unansweredOnly = false),
              ),
              const SizedBox(width: 6),
              _filter(
                '${tr('unanswered')} ( $unanswered )',
                _unansweredOnly,
                () => setState(() => _unansweredOnly = true),
              ),
            ],
          ),
          const SizedBox(height: 24),
          for (final q in visible)
            _QuestionCard(question: q, onReply: () => _reply(q)),
          if (visible.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                tr('no_unanswered'),
                textAlign: TextAlign.center,
                style: almarai(13, color: AppColors.muted),
              ),
            ),
        ],
      ),
    );
  }

  Widget _filter(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 99.4,
        height: 29.14,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(17.14),
          border: selected ? null : Border.all(color: const Color(0xFFDBDBDB)),
        ),
        child: Text(
          label,
          style: almarai(
            10.29,
            weight: bold,
            color: selected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question, required this.onReply});

  final StudentQuestion question;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    final q = question;
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0x3D004957)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InitialAvatar(
                q.initial,
                size: 28,
                color: AppColors.blue,
                fontSize: 11,
              ),
              const SizedBox(width: 10),
              Text(
                q.name,
                style: almarai(13, weight: bold, color: AppColors.primary),
              ),
              const Spacer(),
              Text(q.time, style: almarai(10, color: const Color(0xFF848484))),
            ],
          ),
          const SizedBox(height: 10),
          Text(q.course, style: almarai(12, color: const Color(0xA3004957))),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 28),
            child: Text(
              q.text,
              style: almarai(
                12.5,
                height: 1.65,
                color: const Color(0xFF5A5A5A),
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (q.answered)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('replied'),
                    style: tajawal(
                      11.5,
                      weight: bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const SvgIcon('check_done', size: 12),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: onReply,
                child: Container(
                  height: 29,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgIcon('send', size: 13),
                      const SizedBox(width: 10),
                      Text(
                        tr('reply'),
                        style: almarai(13, weight: bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
