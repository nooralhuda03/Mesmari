import 'package:mesmari_shared/core/theme/app_colors.dart';

import 'package:mesmari_shared/features/courses/data/models/courses_models.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

export 'package:mesmari_shared/features/courses/data/models/courses_models.dart';

/// Course data. Returns the content from the Figma file for now —
/// replace the method bodies with API calls when the backend is ready.
class CoursesRepository {
  const CoursesRepository();

  List<StudentCourseProgress> studentCourses() => [
    StudentCourseProgress(
      tr('c_course_basics_alt'),
      tr('c_lecture_6_of_12'),
      0.48,
      AppColors.teal,
    ),
    StudentCourseProgress(
      tr('c_course_english_alt'),
      tr('c_lecture_2_of_9'),
      0.18,
      AppColors.blue,
    ),
  ];

  List<String> categories() => [
    tr('c_cat_all'),
    'برمجة',
    tr('c_cat_languages'),
    tr('c_cat_math'),
  ];

  List<CatalogCourse> catalog() => [
    CatalogCourse(
      id: 'basics',
      category: tr('programming'),
      title: tr('c_course_basics'),
      subtitle: tr('c_sub_basics'),
      color: AppColors.teal,
      enrolled: true,
    ),
    CatalogCourse(
      id: 'web',
      category: tr('programming'),
      title: tr('c_course_web'),
      subtitle: tr('c_sub_web'),
      color: AppColors.primary,
      enrolled: false,
    ),
    CatalogCourse(
      id: 'english',
      category: tr('c_cat_languages'),
      title: tr('c_course_english'),
      subtitle: tr('c_sub_english'),
      color: AppColors.blue,
      enrolled: true,
    ),
  ];

  List<Lecture> lectures() => [
    Lecture(tr('c_lec_1'), tr('c_min_14'), LectureState.done),
    Lecture(tr('c_lec_2'), tr('c_min_18'), LectureState.done),
    Lecture(tr('c_lec_3'), tr('c_min_22'), LectureState.current),
    Lecture(tr('c_lec_4'), tr('c_min_20'), LectureState.locked),
  ];

  /// Order used on the teacher "my courses" tab.
  List<TeacherCourse> teacherCourses() => [
    TeacherCourse('web', tr('c_course_web'), 19, 18, 41),
    TeacherCourse('data', tr('c_course_data'), 15, 20, 28),
    TeacherCourse('basics', tr('c_course_basics'), 24, 12, 62),
  ];

  /// Order used on the teacher home and reports screens.
  List<TeacherCourse> teacherHomeCourses() => [
    TeacherCourse('basics', tr('c_course_basics_alt'), 24, 12, 62),
    TeacherCourse('web', tr('c_course_web'), 19, 18, 41),
    TeacherCourse('data', tr('c_course_data'), 15, 20, 28),
  ];

  /// Looks a course up by its stable id.
  TeacherCourse? courseById(String id) {
    for (final c in teacherHomeCourses()) {
      if (c.id == id) return c;
    }
    return null;
  }

  List<ManagedLecture> managedLectures() => [
    ManagedLecture(1, tr('c_lecture_intro'), 14),
    ManagedLecture(2, tr('c_lecture_vars'), 18),
    ManagedLecture(3, tr('c_lecture_loops_long'), 22),
    ManagedLecture(4, tr('c_lecture_functions'), 20),
  ];
}
