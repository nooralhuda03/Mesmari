import 'package:flutter/foundation.dart';

/// Which courses each student is enrolled in. Only the teacher assigns
/// courses — students never enrol themselves.
class EnrollmentRepository extends ChangeNotifier {
  EnrollmentRepository._();

  static final EnrollmentRepository instance = EnrollmentRepository._();

  final Map<String, Set<String>> _byStudent = {};

  void seed(Map<String, Set<String>> assignments) {
    _byStudent
      ..clear()
      ..addAll(assignments);
    notifyListeners();
  }

  List<String> coursesFor(String student) =>
      (_byStudent[student] ?? const <String>{}).toList();

  List<String> studentsIn(String course) => _byStudent.entries
      .where((e) => e.value.contains(course))
      .map((e) => e.key)
      .toList();

  bool isAssigned(String student, String course) =>
      _byStudent[student]?.contains(course) ?? false;

  void assign(String student, String course) {
    _byStudent.putIfAbsent(student, () => <String>{}).add(course);
    notifyListeners();
  }

  void unassign(String student, String course) {
    _byStudent[student]?.remove(course);
    notifyListeners();
  }
}
