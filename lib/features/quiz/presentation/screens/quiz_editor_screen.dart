import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// One question being edited.
class _QuestionDraft {
  _QuestionDraft({String prompt = '', String code = '', List<String>? options})
    : prompt = TextEditingController(text: prompt),
      code = TextEditingController(text: code),
      options = (options ?? ['', ''])
          .map((o) => TextEditingController(text: o))
          .toList();

  final TextEditingController prompt;
  final TextEditingController code;
  final List<TextEditingController> options;
  int correct = 0;

  void dispose() {
    prompt.dispose();
    code.dispose();
    for (final o in options) {
      o.dispose();
    }
  }
}

/// Figma 175 — build a multiple-choice quiz question.
class QuizEditorScreen extends StatefulWidget {
  const QuizEditorScreen({super.key, required this.lectureTitle});

  final String lectureTitle;

  @override
  State<QuizEditorScreen> createState() => _QuizEditorScreenState();
}

class _QuizEditorScreenState extends State<QuizEditorScreen> {
  late final List<_QuestionDraft> _questions = [
    _QuestionDraft(
      prompt: tr('c_q_output'),
      code: 'for  i  in range ( 3 ) : \n      print ( i )',
      options: ['0  1  2', ' 1  2  3', '0 1  2  3', tr('c_q_code_error_sp')],
    ),
  ];
  int _index = 0;

  _QuestionDraft get _question => _questions[_index];

  @override
  void dispose() {
    for (final q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(_QuestionDraft());
      _index = _questions.length - 1;
    });
  }

  void _go(int delta) {
    final next = _index + delta;
    if (next < 0 || next >= _questions.length) return;
    setState(() => _index = next);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          children: [
            EditorHeader(title: '${tr('quiz_for')} : ${widget.lectureTitle}'),
            const SizedBox(height: 4),
            Row(
              children: [
                GestureDetector(
                  onTap: _addQuestion,
                  child: Pill(
                    '+ ${tr('add_question')}',
                    width: 102,
                    padding: EdgeInsets.zero,
                    textStyle: almarai(
                      12,
                      weight: bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _index == 0 ? null : () => _go(-1),
                  icon: const Icon(Icons.chevron_right, size: 20),
                ),
                Text(
                  '${tr('question')} ${_index + 1} ${tr('of')} ${_questions.length}',
                  style: almarai(
                    10,
                    weight: bold,
                    color: const Color(0xFF7B7B7B),
                  ),
                ),
                IconButton(
                  onPressed: _index == _questions.length - 1
                      ? null
                      : () => _go(1),
                  icon: const Icon(Icons.chevron_left, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Text(
                tr('question_text'),
                style: almarai(
                  12,
                  weight: bold,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 43,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: AlignmentDirectional.centerStart,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: TextField(
                controller: _question.prompt,
                style: almarai(12, color: const Color(0xFF676767)),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: tr('question_text_hint'),
                  hintStyle: almarai(12, color: AppColors.hint),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 84,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _question.code,
                maxLines: 3,
                textDirection: TextDirection.ltr,
                style: almarai(15, weight: bold, color: Colors.white),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: tr('code_optional'),
                  hintStyle: almarai(13, color: Colors.white38),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(tr('answer_options'), style: almarai(15, weight: bold)),
            const SizedBox(height: 16),
            for (var i = 0; i < _question.options.length; i++) _optionRow(i),
            const SizedBox(height: 11),
            GestureDetector(
              onTap: () => setState(
                () => _question.options.add(TextEditingController()),
              ),
              child: Container(
                height: 41,
                padding: const EdgeInsetsDirectional.only(start: 24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        '+ ',
                        style: almarai(
                          20,
                          weight: bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      tr('add_option'),
                      style: almarai(
                        14,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: tr('save_quiz'),
              height: 51,
              radius: 10,
              style: almarai(15, weight: bold, color: Colors.white),
              onTap: () {
                Navigator.of(context).pop();
                showSnack(
                  context,
                  '${tr('quiz_saved')} (${_questions.length})',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionRow(int i) {
    final selected = i == _question.correct;
    final controller = _question.options[i];
    final isArabic = RegExp(r'[؀-ۿ]').hasMatch(controller.text);
    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.only(start: 16, end: 15),
      decoration: BoxDecoration(
        color: selected ? AppColors.mint : AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? const Color(0xFF0DAAC8) : const Color(0xFFD8D8D8),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _question.correct = i),
            child: Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.primary : AppColors.surface,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.border,
                  width: 1.5,
                ),
              ),
              child: selected ? const SvgIcon('t_check', size: 11) : null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              textAlign: TextAlign.right,
              style: almarai(
                isArabic ? 13 : 15,
                weight: bold,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: tr('option_text'),
                hintStyle: almarai(13, color: AppColors.hint),
              ),
            ),
          ),
          GestureDetector(
            onTap: _question.options.length <= 2
                ? null
                : () => setState(() {
                    _question.options.removeAt(i).dispose();
                    if (_question.correct >= _question.options.length) {
                      _question.correct = 0;
                    }
                  }),
            child: const SvgIcon('t_trash', size: 20),
          ),
        ],
      ),
    );
  }
}
