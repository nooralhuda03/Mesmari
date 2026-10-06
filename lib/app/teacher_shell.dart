import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';
import 'package:mesmari_teacher/features/home/presentation/screens/teacher_home_screen.dart';
import 'package:mesmari_teacher/features/courses/presentation/screens/teacher_courses_screen.dart';
import 'package:mesmari_teacher/features/students/presentation/screens/teacher_students_screen.dart';
import 'package:mesmari_teacher/features/questions/presentation/screens/teacher_questions_screen.dart';

/// Teacher area with the 4-tab bottom bar.
class TeacherShell extends StatefulWidget {
  const TeacherShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<TeacherShell> createState() => _TeacherShellState();
}

class _TeacherShellState extends State<TeacherShell> {
  late int _index = widget.initialIndex;

  List<NavItem> get _items => [
    NavItem(tr('nav_home'), 't_home_inactive', 'nav_home'),
    NavItem(tr('nav_courses'), 'nav_courses', 't_courses_active'),
    NavItem(tr('nav_students'), 't_people', 't_people_active'),
    // The exported "note" icon is grey in every state, so tint it when active.
    NavItem(
      tr('nav_questions'),
      't_note',
      't_note_active',
      activeTint: AppColors.primary,
    ),
  ];

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          TeacherHomeScreen(onNavigate: _go),
          const TeacherCoursesScreen(),
          const TeacherStudentsScreen(),
          const TeacherQuestionsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        items: _items,
        currentIndex: _index,
        onTap: _go,
      ),
    );
  }
}
