import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/meetings/data/meetings_repository.dart';
import 'package:mesmari_shared/features/meetings/presentation/widgets/past_meeting_tile.dart';

/// Figma 179 — teacher's weekly meetings (contains the linked node 137:3368).
class TeacherMeetingsScreen extends StatelessWidget {
  const TeacherMeetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 21, 20, 24),
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 4, end: 12),
              child: Row(
                children: [
                  Text(
                    tr('my_weekly_meetings'),
                    style: cairo(20, weight: bold, color: AppColors.primary),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(AppRoutes.scheduleMeeting),
                    child: Container(
                      width: 31,
                      height: 31,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '+',
                        style: cairo(
                          20,
                          weight: bold,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _NextMeetingCard(onStart: () => openMeetingLink(context)),
            const SizedBox(height: 20),
            Text(tr('past_meetings'), style: cairo(15, weight: bold)),
            const SizedBox(height: 16),
            for (final r in const MeetingsRepository().recordings())
              PastMeetingTile(
                title: r.title,
                date: r.date,
                attendance: r.attendance,
                onPlay: () => Navigator.of(context).pushNamed(
                  AppRoutes.videoPlayer,
                  arguments: PlayerArgs(title: r.title, subtitle: r.date),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NextMeetingCard extends StatelessWidget {
  const _NextMeetingCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mint, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('auto_scheduled'),
                style: almarai(11.5, color: AppColors.muted),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tr('next_label'),
                  style: almarai(
                    10,
                    weight: extraBold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            tr('c_meeting_live'),
            style: almarai(15, weight: extraBold, color: AppColors.text),
          ),
          const SizedBox(height: 4),
          Text(
            tr('c_meeting_time'),
            style: almarai(12.5, color: AppColors.muted),
          ),
          const SizedBox(height: 12),
          Text(
            tr('c_meeting_18_registered'),
            style: almarai(11.5, color: AppColors.primary),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            label: tr('start_meeting'),
            height: 42,
            radius: 12,
            style: almarai(13.5, weight: extraBold, color: Colors.white),
            onTap: onStart,
          ),
        ],
      ),
    );
  }
}
