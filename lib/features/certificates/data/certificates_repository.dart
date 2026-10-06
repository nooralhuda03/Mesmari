import 'package:mesmari_teacher/features/certificates/data/models/certificates_models.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

export 'package:mesmari_teacher/features/certificates/data/models/certificates_models.dart';

class CertificatesRepository {
  const CertificatesRepository();

  List<IssuedCertificate> issued() => [
    IssuedCertificate(
      tr('c_student_noor'),
      tr('c_course_basics'),
      tr('c_date_sep_2'),
    ),
    IssuedCertificate(
      tr('c_student_zahraa'),
      tr('c_course_basics'),
      tr('c_date_aug_30'),
    ),
    IssuedCertificate(
      tr('c_student_karrar'),
      tr('c_course_web'),
      tr('c_date_aug_28'),
    ),
  ];
}
