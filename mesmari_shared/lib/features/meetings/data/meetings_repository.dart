import 'package:mesmari_shared/features/meetings/data/models/meetings_models.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

export 'package:mesmari_shared/features/meetings/data/models/meetings_models.dart';
export 'package:mesmari_shared/features/meetings/data/meeting_link_controller.dart';

class MeetingsRepository {
  const MeetingsRepository();

  List<Recording> recordings() => [
    Recording(tr('c_rec_1'), tr('c_rec_1_date'), tr('c_rec_1_desc'), '21 / 24'),
    Recording(tr('c_rec_2'), tr('c_rec_2_date'), '', '19 / 24'),
    Recording(tr('c_rec_3'), tr('c_rec_3_date'), '', '24 / 24'),
  ];
}
