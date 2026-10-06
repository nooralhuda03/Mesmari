/// A question a student asked the teacher.
class StudentQuestion {
  StudentQuestion(
    this.id,
    this.name,
    this.initial,
    this.time,
    this.course,
    this.text, {
    this.answered = false,
  });

  /// Stable identifier of the student who asked — never translated.
  final String id;
  final String name;
  final String initial;
  final String time;
  final String course;
  final String text;
  bool answered;
}
