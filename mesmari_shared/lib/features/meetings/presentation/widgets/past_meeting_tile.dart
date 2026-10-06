import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Recorded meeting row: play button, title, date and attendance.
/// Figma node 137:3368 ("Frame 87").
class PastMeetingTile extends StatelessWidget {
  const PastMeetingTile({
    super.key,
    required this.title,
    required this.date,
    this.attendance,
    this.onPlay,
  });

  final String title;
  final String date;
  final String? attendance;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.only(start: 17, end: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPlay,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const SvgIcon('play', size: 15),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: cairo(13, weight: bold)),
                Row(
                  children: [
                    Text(
                      date,
                      style: cairo(10, color: const Color(0xFF737373)),
                    ),
                    const Spacer(),
                    if (attendance != null)
                      Text(
                        attendance!,
                        textDirection: TextDirection.ltr,
                        style: cairo(10, color: const Color(0xFF757575)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
