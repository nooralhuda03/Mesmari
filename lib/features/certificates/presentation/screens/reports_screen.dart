import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';
import 'package:mesmari_teacher/features/certificates/data/certificates_repository.dart';

/// Figma 180 — reports and certificates.
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 21, 16, 24),
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Text(
                tr('reports_certificates'),
                style: cairo(20, weight: bold, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: StatBox(
                    value: '16',
                    label: tr('certificates_issued'),
                    height: 78,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: StatBox(
                    value: '44 %',
                    label: tr('avg_completion'),
                    height: 78,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: StatBox(
                    value: '58',
                    label: tr('total_students'),
                    height: 78,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(tr('completion_per_course'), style: cairo(15, weight: bold)),
            const SizedBox(height: 17),
            _Panel(
              children: [
                for (final c in const CoursesRepository().teacherHomeCourses())
                  _CompletionRow(title: c.title, value: c.completion),
              ],
            ),
            const SizedBox(height: 27),
            Text(tr('recent_certificates'), style: cairo(15, weight: bold)),
            const SizedBox(height: 20),
            _Panel(
              children: [
                for (final c in const CertificatesRepository().issued())
                  _CertificateRow(cert: c),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.fromLTRB(19, 23, 19, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD8D8D8)),
      ),
      child: Column(children: children),
    );
  }
}

BoxDecoration _rowDecoration() => BoxDecoration(
  color: AppColors.card,
  borderRadius: BorderRadius.circular(8.75),
  border: Border.all(color: const Color(0xFFE2E2E2), width: 0.875),
);

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 17),
      decoration: _rowDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                title,
                style: almarai(12, weight: bold, color: AppColors.primary),
              ),
              const Spacer(),
              Text(
                '$value %',
                textDirection: TextDirection.ltr,
                style: almarai(12, weight: bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ProgressLine(value: value / 100),
        ],
      ),
    );
  }
}

class _CertificateRow extends StatelessWidget {
  const _CertificateRow({required this.cert});

  final IssuedCertificate cert;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.only(start: 17, end: 17),
      decoration: _rowDecoration(),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.mint,
              shape: BoxShape.circle,
            ),
            child: const SvgIcon('award_teal', size: 15),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cert.name,
                  style: almarai(12, weight: bold, color: AppColors.primary),
                ),
                const SizedBox(height: 7),
                Text(
                  cert.course,
                  style: almarai(10, color: const Color(0xFF868686)),
                ),
              ],
            ),
          ),
          Text(cert.date, style: almarai(10, color: const Color(0xFF838383))),
        ],
      ),
    );
  }
}
