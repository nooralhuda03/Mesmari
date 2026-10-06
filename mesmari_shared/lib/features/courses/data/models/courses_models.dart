import 'package:flutter/painting.dart';

/// A course the student is enrolled in, with progress (home screen).
class StudentCourseProgress {
  const StudentCourseProgress(
    this.title,
    this.lecture,
    this.progress,
    this.color,
  );
  final String title;
  final String lecture;
  final double progress;
  final Color color;
}

/// A course in the catalogue.
class CatalogCourse {
  const CatalogCourse({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.enrolled,
    this.rating = '4.5',
  });

  /// Stable identifier — never translated.
  final String id;
  final String category;
  final String title;
  final String subtitle;
  final Color color;
  final bool enrolled;
  final String rating;
}

enum LectureState { done, current, locked }

/// A lecture as seen by the student.
class Lecture {
  const Lecture(this.title, this.duration, this.state);
  final String title;
  final String duration;
  final LectureState state;
}

/// A course owned by the teacher.
class TeacherCourse {
  const TeacherCourse(
    this.id,
    this.title,
    this.students,
    this.lectures,
    this.completion,
  );

  /// Stable identifier — never translated.
  final String id;
  final String title;
  final int students;
  final int lectures;
  final int completion;
}

/// A lecture as managed by the teacher.
class ManagedLecture {
  const ManagedLecture(this.number, this.title, this.minutes);
  final int number;
  final String title;
  final int minutes;
}
