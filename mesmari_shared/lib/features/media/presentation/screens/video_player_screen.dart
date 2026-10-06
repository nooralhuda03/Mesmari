import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Lecture / recording player.
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.args});

  final PlayerArgs args;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  Timer? _timer;
  bool _playing = true;
  double _seconds = 0;
  double _speed = 1;

  double get _total => widget.args.duration.inSeconds.toDouble();

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _seconds = (_seconds + _speed).clamp(0, _total);
        if (_seconds >= _total) {
          _playing = false;
          t.cancel();
        }
      });
    });
  }

  void _toggle() {
    setState(() => _playing = !_playing);
    if (_playing) {
      if (_seconds >= _total) _seconds = 0;
      _start();
    } else {
      _timer?.cancel();
    }
  }

  void _seek(double by) {
    setState(() => _seconds = (_seconds + by).clamp(0, _total));
  }

  static String _fmt(double seconds) {
    final d = Duration(seconds: seconds.round());
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1416),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.args.title,
                    overflow: TextOverflow.ellipsis,
                    style: cairo(14, weight: bold, color: Colors.white),
                  ),
                ),
                IconButton(
                  onPressed: () => showOptionsSheet(
                    context,
                    title: tr('video_options'),
                    options: [
                      SheetOption(
                        Icons.download_outlined,
                        tr('download_video'),
                      ),
                      SheetOption(Icons.hd_outlined, tr('video_quality')),
                      SheetOption(
                        Icons.closed_caption_outlined,
                        tr('subtitles'),
                      ),
                    ],
                  ),
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                ),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                // 16:10, but never tall enough to push the controls off
                // screen on short or landscape displays.
                height: (constraints.maxWidth * 10 / 16).clamp(0.0, 280.0),
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: GestureDetector(
                      onTap: _toggle,
                      child: Container(
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0x33FFFFFF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 3,
                      activeTrackColor: AppColors.mint,
                      inactiveTrackColor: const Color(0x33FFFFFF),
                      thumbColor: AppColors.mint,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
                    ),
                    child: Slider(
                      value: _seconds,
                      max: _total,
                      onChanged: (v) => setState(() => _seconds = v),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _fmt(_seconds),
                          textDirection: TextDirection.ltr,
                          style: cairo(11, color: Colors.white70),
                        ),
                        Text(
                          _fmt(_total),
                          textDirection: TextDirection.ltr,
                          style: cairo(11, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _seek(-10),
                        icon: const Icon(
                          Icons.replay_10,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 18),
                      IconButton(
                        onPressed: _toggle,
                        icon: Icon(
                          _playing
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                      const SizedBox(width: 18),
                      IconButton(
                        onPressed: () => _seek(10),
                        icon: const Icon(
                          Icons.forward_10,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.args.title,
                      style: cairo(15, weight: bold, color: AppColors.primary),
                    ),
                    if (widget.args.subtitle != null)
                      Text(
                        widget.args.subtitle!,
                        style: almarai(12, color: AppColors.muted),
                      ),
                    const SizedBox(height: 14),
                    Text(
                      tr('playback_speed'),
                      style: almarai(12, weight: bold, color: AppColors.muted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        for (final speed in const [0.75, 1.0, 1.25, 1.5])
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 6),
                            child: GestureDetector(
                              onTap: () => setState(() => _speed = speed),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: _speed == speed
                                      ? AppColors.primary
                                      : AppColors.card,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  '${speed}x',
                                  textDirection: TextDirection.ltr,
                                  style: almarai(
                                    11,
                                    weight: bold,
                                    color: _speed == speed
                                        ? Colors.white
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
