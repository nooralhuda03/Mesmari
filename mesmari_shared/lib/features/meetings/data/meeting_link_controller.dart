import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mesmari_shared/core/l10n/app_strings.dart';
import 'package:mesmari_shared/core/utils/snackbar.dart';

/// The external join link (Zoom / Google Meet / ...) for the next
/// scheduled meeting, set by the teacher in [ScheduleMeetingScreen].
class MeetingLinkController extends ChangeNotifier {
  MeetingLinkController._();

  static final MeetingLinkController instance = MeetingLinkController._();

  String _link = '';
  String get link => _link;

  void setLink(String link) {
    _link = link.trim();
    notifyListeners();
  }
}

/// Opens the stored meeting link in an external app (browser / Zoom / Meet),
/// replacing the in-app mock live-meeting room.
Future<void> openMeetingLink(BuildContext context) async {
  final link = MeetingLinkController.instance.link;
  if (link.isEmpty) {
    showSnack(context, tr('no_meeting_link'));
    return;
  }
  final uri = Uri.tryParse(link);
  if (uri == null || !uri.hasScheme) {
    showSnack(context, tr('invalid_meeting_link'));
    return;
  }
  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!opened && context.mounted) {
    showSnack(context, tr('cant_open_link'));
  }
}
