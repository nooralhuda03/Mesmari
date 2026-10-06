import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';

/// Figma 174 — edit / create a lecture.
class LectureEditScreen extends StatefulWidget {
  const LectureEditScreen({super.key, this.lecture});

  /// Pass `null` to create a new lecture.
  final ManagedLecture? lecture;

  @override
  State<LectureEditScreen> createState() => _LectureEditScreenState();
}

class _LectureEditScreenState extends State<LectureEditScreen> {
  bool _isTask = true;

  @override
  Widget build(BuildContext context) {
    final lecture = widget.lecture;
    final title = lecture == null
        ? tr('new_lecture')
        : '${tr('edit')} : ${lecture.title}';
    final labelStyle = almarai(12.25, weight: bold, color: AppColors.muted);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                children: [
                  EditorHeader(title: title),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => showOptionsSheet(
                      context,
                      title: tr('lecture_video'),
                      options: [
                        SheetOption(Icons.folder_outlined, tr('from_device')),
                        SheetOption(
                          Icons.videocam_outlined,
                          tr('record_video'),
                        ),
                        SheetOption(Icons.link, tr('youtube_link')),
                      ],
                    ),
                    child: Container(
                      height: 121,
                      padding: const EdgeInsetsDirectional.only(start: 17),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFC2C2C2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(child: SvgIcon('upload', size: 26)),
                          const SizedBox(height: 9),
                          Text(
                            tr('upload_lecture_video'),
                            style: almarai(13, weight: bold),
                          ),
                          const SizedBox(height: 11),
                          Text(
                            tr('upload_hint'),
                            style: almarai(10, color: const Color(0x70000000)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 17, 21, 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFC7C7C7)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(tr('lecture_title'), style: labelStyle),
                        const SizedBox(height: 8),
                        FormInput(initialValue: lecture?.title ?? ''),
                        const SizedBox(height: 14),
                        Text(tr('duration'), style: labelStyle),
                        const SizedBox(height: 8),
                        FormInput(
                          initialValue: lecture == null
                              ? ''
                              : '${lecture.minutes} ${tr('minute')}',
                        ),
                        const SizedBox(height: 24),
                        Text(
                          tr('attached_task'),
                          style: almarai(14, weight: bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _toggle(
                                tr('pdf_resource'),
                                !_isTask,
                                () => setState(() => _isTask = false),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: _toggle(
                                tr('practical_task'),
                                _isTask,
                                () => setState(() => _isTask = true),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        if (_isTask) _taskBox() else _pdfBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: PrimaryButton(
                label: tr('save_publish_lecture'),
                height: 48,
                radius: 8.75,
                style: almarai(13, weight: bold, color: Colors.white),
                onTap: () {
                  Navigator.of(context).pop();
                  showSnack(context, tr('lecture_saved'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggle(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32.36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(8.75),
          border: selected
              ? null
              : Border.all(color: const Color(0xFFE2E2E2), width: 0.875),
        ),
        child: Text(
          label,
          style: almarai(
            10.5,
            weight: bold,
            color: selected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _taskBox() {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(17, 14, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8.75),
        border: Border.all(color: const Color(0xFFE2E2E2), width: 0.875),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            tr('task_text'),
            style: almarai(11.37, weight: bold, color: const Color(0xFF535353)),
          ),
          TextFormField(
            initialValue: tr('c_task_even_alt'),
            maxLines: 3,
            minLines: 2,
            style: almarai(12, height: 1.65, color: const Color(0xFF7C7C7C)),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Widget _pdfBox() {
    return GestureDetector(
      onTap: () => showOptionsSheet(
        context,
        title: tr('lecture_file'),
        options: [
          SheetOption(Icons.folder_outlined, tr('from_device')),
          SheetOption(Icons.cloud_outlined, tr('from_drive')),
        ],
      ),
      child: Container(
        height: 98,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(8.75),
          border: Border.all(color: const Color(0xFFE2E2E2), width: 0.875),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgIcon('pdf_file', size: 22),
            const SizedBox(height: 8),
            Text(
              tr('upload_pdf'),
              style: almarai(
                11.37,
                weight: bold,
                color: const Color(0xFF535353),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
