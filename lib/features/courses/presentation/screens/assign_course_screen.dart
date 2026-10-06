import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_shared/features/courses/data/courses_repository.dart';
import 'package:mesmari_shared/features/enrollment/data/enrollment_repository.dart';

import '../../../students/data/students_repository.dart';

/// The teacher picks which students are enrolled in a course.
class AssignCourseScreen extends StatefulWidget {
  const AssignCourseScreen({super.key, required this.courseId});

  /// Stable course id.
  final String courseId;

  @override
  State<AssignCourseScreen> createState() => _AssignCourseScreenState();
}

class _AssignCourseScreenState extends State<AssignCourseScreen> {
  final _repo = EnrollmentRepository.instance;
  late final _students = const StudentsRepository().progress();
  late final _courses = const CoursesRepository().teacherHomeCourses();
  late String _course = widget.courseId;

  String _courseTitle(String id) =>
      const CoursesRepository().courseById(id)?.title ?? id;
  final _newStudent = TextEditingController();

  @override
  void dispose() {
    _newStudent.dispose();
    super.dispose();
  }

  Future<void> _pickCourse() async {
    final choice = await showOptionsSheet(
      context,
      title: tr('choose_course'),
      options: [
        for (final c in _courses)
          SheetOption(Icons.menu_book_outlined, c.title),
      ],
    );
    if (choice == null) return;
    for (final c in _courses) {
      if (c.title == choice) setState(() => _course = c.id);
    }
  }

  void _addStudent() {
    final name = _newStudent.text.trim();
    if (name.isEmpty) return;
    _repo.assign(name, _course);
    _newStudent.clear();
    setState(() {});
    showSnack(context, '${tr('student_added')} $name');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _repo,
      builder: (context, _) {
        final enrolled = _repo.studentsIn(_course);
        // students from the roster, plus anyone added by hand
        final ids = <String>[
          ..._students.map((s) => s.id),
          ...enrolled.where((id) => !_students.any((s) => s.id == id)),
        ];
        String nameOf(String id) {
          for (final s in _students) {
            if (s.id == id) return s.name.trim();
          }
          return id;
        }

        return AppScreen(
          title: tr('course_students'),
          subtitle: tr('assign_subtitle'),
          content: [
            AppCard(
              onTap: _pickCourse,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _courseTitle(_course),
                      style: almarai(13, weight: bold, color: AppColors.text),
                    ),
                  ),
                  Text(
                    '${enrolled.length} ${tr('students_word')}',
                    style: almarai(11, color: AppColors.muted),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.muted,
                    size: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SectionTitle(tr('add_student')),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: AlignmentDirectional.centerStart,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E2E2)),
                    ),
                    child: TextField(
                      controller: _newStudent,
                      style: almarai(13, color: AppColors.text),
                      onSubmitted: (_) => _addStudent(),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: tr('student_name_hint'),
                        hintStyle: almarai(12.5, color: AppColors.hint),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _addStudent,
                  child: Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SectionTitle(tr('nav_students')),
            for (final id in ids)
              AppCard(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                child: Row(
                  children: [
                    InitialAvatar(
                      nameOf(id).substring(0, 1),
                      size: 34,
                      fontSize: 13,
                      color: AppColors.blue,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        nameOf(id),
                        style: almarai(
                          13,
                          weight: bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Switch(
                      value: _repo.isAssigned(id, _course),
                      onChanged: (v) => v
                          ? _repo.assign(id, _course)
                          : _repo.unassign(id, _course),
                    ),
                  ],
                ),
              ),
          ],
          footer: PrimaryButton(
            label: tr('save'),
            height: 48,
            radius: 10,
            style: almarai(14, weight: bold, color: Colors.white),
            onTap: () {
              Navigator.of(context).pop();
              showSnack(
                context,
                '${tr('students_updated')} ${_courseTitle(_course)}',
              );
            },
          ),
        );
      },
    );
  }
}
