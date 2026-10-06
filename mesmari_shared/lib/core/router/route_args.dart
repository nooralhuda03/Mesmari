/// Arguments passed through [AppRoutes]. They live in core so a feature can
/// navigate to another feature's screen without importing it.
class PlayerArgs {
  const PlayerArgs({
    required this.title,
    this.subtitle,
    this.duration = const Duration(minutes: 22),
  });

  final String title;
  final String? subtitle;
  final Duration duration;
}

class DocArgs {
  const DocArgs({required this.title, this.subtitle, this.pages = 6});

  final String title;
  final String? subtitle;
  final int pages;
}

class LiveMeetingArgs {
  const LiveMeetingArgs({required this.title, this.isHost = false});

  final String title;
  final bool isHost;
}

class QuizResultArgs {
  const QuizResultArgs({required this.score, required this.total});

  final int score;
  final int total;
}
