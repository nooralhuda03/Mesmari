import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import 'package:mesmari_shared/features/profile/data/profile_controller.dart';
import 'package:mesmari_shared/features/profile/presentation/widgets/account_actions.dart';

/// Figma 178 — teacher profile and settings.
class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 19, 16, 24),
          children: [
            ListenableBuilder(
              listenable: ProfileController.instance,
              builder: (context, _) {
                final profile = ProfileController.instance.profile;
                return Column(
                  children: [
                    SizedBox(
                      width: 106,
                      height: 106,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const SvgIcon('t_avatar_circle', size: 106),
                          Text(
                            profile.initials,
                            style: cairo(
                              24,
                              weight: bold,
                              color: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.displayName,
                      textAlign: TextAlign.center,
                      style: almarai(20, weight: bold),
                    ),
                    const SizedBox(height: 14),
                    Pill(
                      profile.displayHeadline,
                      width: 110,
                      height: 28,
                      color: AppColors.blueSoft,
                      padding: EdgeInsets.zero,
                      textStyle: almarai(
                        10.29,
                        weight: bold,
                        color: AppColors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.displayBio,
                      textAlign: TextAlign.center,
                      style: almarai(12, height: 1.65, color: AppColors.muted),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatBox(
                    value: '58',
                    label: tr('my_students'),
                    icon: 'people_small',
                    iconSize: 17,
                  ),
                ),
                SizedBox(width: 4.7),
                Expanded(
                  child: StatBox(
                    value: '4.8',
                    label: tr('my_rating'),
                    icon: 'star_outline',
                  ),
                ),
                SizedBox(width: 4.7),
                Expanded(
                  child: StatBox(
                    value: '3',
                    label: tr('my_courses'),
                    icon: 't_book',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              tr('account_settings'),
              style: cairo(16, weight: bold, color: AppColors.primary),
            ),
            const SizedBox(height: 16),
            SettingsTile(
              label: tr('profile_and_bio'),
              icon: 't_user',
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.editProfile),
            ),
            SettingsTile(
              label: tr('meetings_schedule'),
              icon: 'note_cal',
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.teacherMeetings),
            ),
            SettingsTile(
              label: tr('notifications'),
              icon: 't_notification',
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.notificationSettings),
            ),
            SettingsTile(
              label: tr('payments'),
              icon: 'cards',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.earnings),
            ),
            SettingsTile(
              label: tr('appearance'),
              iconData: Icons.dark_mode_outlined,
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.appearance),
            ),
            SettingsTile(
              label: tr('language'),
              iconData: Icons.language,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.language),
            ),
            SettingsTile(
              label: tr('reports_certificates'),
              icon: 'book_open',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.reports),
            ),
            SettingsTile(
              label: tr('delete_account'),
              icon: 't_trash_red',
              iconWidth: 12,
              iconHeight: 15,
              iconBg: const Color(0x14FF0004),
              danger: true,
              onTap: () => confirmDeleteAccount(context),
            ),
            SettingsTile(
              label: tr('log_out'),
              icon: 't_logout',
              iconWidth: 15,
              iconHeight: 12,
              iconBg: const Color(0xFFFFEBEB),
              danger: true,
              onTap: () => logOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
