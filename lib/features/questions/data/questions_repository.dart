import 'package:mesmari_teacher/features/questions/data/models/questions_models.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

export 'package:mesmari_teacher/features/questions/data/models/questions_models.dart';

class QuestionsRepository {
  const QuestionsRepository();

  /// Returns a fresh list each call (items are mutated when answered).
  List<StudentQuestion> questions() => [
    StudentQuestion(
      'mustafa',
      tr('c_student_mustafa'),
      tr('c_i_m'),
      tr('c_time_15min'),
      tr('c_course_basics'),
      tr('c_q_mustafa'),
    ),
    StudentQuestion(
      'zahraa',
      tr('c_student_zahraa'),
      tr('c_i_z'),
      tr('c_time_1h'),
      tr('c_course_web'),
      tr('c_chat_zahraa_long'),
    ),
    StudentQuestion(
      'heba',
      tr('c_student_heba'),
      tr('c_i_h'),
      tr('c_time_3h'),
      tr('c_course_basics_alt'),
      tr('c_chat_heba_1'),
    ),
    StudentQuestion(
      'karrar',
      tr('c_student_karrar'),
      tr('c_i_k'),
      tr('c_time_yesterday'),
      tr('c_course_data'),
      tr('c_q_karrar'),
      answered: true,
    ),
  ];
}
