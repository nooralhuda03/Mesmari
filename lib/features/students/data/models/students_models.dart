import 'package:flutter/painting.dart';

/// A student's progress in a course (teacher view).
class StudentProgress {
  const StudentProgress(
    this.id,
    this.name,
    this.initial,
    this.color,
    this.progress, {
    this.needsReminder = false,
  });

  /// Stable identifier — never translated.
  final String id;
  final String name;
  final String initial;
  final Color color;
  final double progress;
  final bool needsReminder;
}
