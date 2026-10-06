import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Simple document viewer for lecture summaries and certificates.
class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key, required this.args});

  final DocArgs args;

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final _pageController = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_page + delta).clamp(0, widget.args.pages - 1);
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20292B),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 8, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.args.title,
                          style: cairo(15, weight: bold, color: Colors.white),
                        ),
                        if (widget.args.subtitle != null)
                          Text(
                            widget.args.subtitle!,
                            style: almarai(11, color: Colors.white70),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.args.pages,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.args.title} - ${tr('page')} ${index + 1}',
                        style: almarai(13, weight: bold, color: AppColors.text),
                      ),
                      const SizedBox(height: 16),
                      for (var line = 0; line < 14; line++)
                        Container(
                          height: 8,
                          margin: const EdgeInsets.only(bottom: 12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: line % 5 == 4
                                ? const Color(0xFFF0F2F2)
                                : const Color(0xFFE6EAEA),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _go(-1),
                    icon: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  Text(
                    '${_page + 1} / ${widget.args.pages}',
                    textDirection: TextDirection.ltr,
                    style: cairo(12, color: Colors.white70),
                  ),
                  IconButton(
                    onPressed: () => _go(1),
                    icon: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: tr('download_file'),
                      height: 46,
                      radius: 10,
                      style: almarai(13, weight: bold, color: Colors.white),
                      onTap: () => showSnack(context, tr('file_saved')),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      label: tr('share'),
                      height: 46,
                      radius: 10,
                      color: AppColors.card,
                      style: almarai(
                        13,
                        weight: bold,
                        color: AppColors.primary,
                      ),
                      onTap: () => showOptionsSheet(
                        context,
                        title: tr('share_file'),
                        options: [
                          SheetOption(
                            Icons.chat_bubble_outline,
                            tr('whatsapp'),
                          ),
                          SheetOption(Icons.send_outlined, tr('telegram')),
                          SheetOption(Icons.link, tr('copy_link')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
