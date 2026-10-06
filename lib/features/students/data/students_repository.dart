import 'package:mesmari_shared/core/theme/app_colors.dart';

import 'package:mesmari_teacher/features/students/data/models/students_models.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

export 'package:mesmari_teacher/features/students/data/models/students_models.dart';

class StudentsRepository {
  const StudentsRepository();

  List<StudentProgress> progress() => [
    StudentProgress(
      'noor',
      tr('c_student_noor'),
      tr('c_i_n'),
      AppColors.primary,
      0.72,
    ),
    StudentProgress(
      'karrar',
      tr('c_student_karrar'),
      tr('c_i_k'),
      AppColors.blue,
      0.61,
    ),
    StudentProgress(
      'ahmed',
      tr('c_student_ahmed'),
      tr('c_i_a'),
      AppColors.blue,
      0.48,
    ),
    StudentProgress(
      'zahraa',
      tr('c_student_zahraa'),
      tr('c_i_z'),
      AppColors.primary,
      0.35,
    ),
    StudentProgress(
      'mustafa',
      tr('c_student_mustafa'),
      tr('c_i_m'),
      AppColors.blue,
      0.22,
      needsReminder: true,
    ),
    StudentProgress(
      'heba',
      tr('c_student_heba'),
      tr('c_i_h'),
      AppColors.blue,
      0.12,
      needsReminder: true,
    ),
  ];
}
