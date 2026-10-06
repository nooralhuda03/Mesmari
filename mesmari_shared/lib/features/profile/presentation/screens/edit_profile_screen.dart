import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

import 'package:mesmari_shared/features/profile/data/profile_controller.dart';

/// Edit the signed-in user's name, phone and details.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _controller = ProfileController.instance;
  late final UserProfile _initial = _controller.profile;
  late final _name = TextEditingController(text: _initial.displayName);
  late final _phone = TextEditingController(text: _initial.phone);
  late final _address = TextEditingController(text: _initial.displayAddress);
  late final _headline = TextEditingController(text: _initial.displayHeadline);
  late final _bio = TextEditingController(text: _initial.displayBio);
  late String _initials = _initial.initials;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _headline.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    if (name.isEmpty) {
      showSnack(context, tr('write_full_name'));
      return;
    }
    _controller.save(
      _initial.copyWith(
        name: name,
        phone: _phone.text.trim(),
        address: _address.text.trim(),
        headline: _headline.text.trim(),
        bio: _bio.text.trim(),
      ),
    );
    Navigator.of(context).pop();
    showSnack(context, tr('changes_saved'));
  }

  Future<void> _pickPhoto() async {
    final choice = await showOptionsSheet(
      context,
      title: tr('profile_photo'),
      options: [
        SheetOption(Icons.photo_camera_outlined, tr('take_photo')),
        SheetOption(Icons.photo_library_outlined, tr('choose_from_gallery')),
        SheetOption(Icons.delete_outline, tr('remove_photo')),
      ],
    );
    if (choice != null && mounted) showSnack(context, choice);
  }

  @override
  Widget build(BuildContext context) {
    final teacher = AppFlavor.isTeacher;
    return AppScreen(
      title: tr('personal_info'),
      subtitle: tr('edit_profile_subtitle'),
      content: [
        Center(
          child: GestureDetector(
            onTap: _pickPhoto,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: teacher ? AppColors.blueSoft : AppColors.mint,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _initials,
                        style: cairo(
                          22,
                          weight: bold,
                          color: teacher ? AppColors.blue : AppColors.primary,
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.card, width: 2),
                      ),
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  tr('change_photo'),
                  style: almarai(12, weight: bold, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        LabeledField(
          label: tr('full_name'),
          controller: _name,
          hint: tr('write_your_name'),
          onChanged: (v) =>
              setState(() => _initials = UserProfile.initialsOf(v)),
        ),
        LabeledField(
          label: tr('phone_number'),
          controller: _phone,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
        ),
        if (teacher) ...[
          LabeledField(
            label: tr('specialty'),
            controller: _headline,
            hint: tr('specialty_hint'),
          ),
          LabeledField(
            label: tr('about_you'),
            controller: _bio,
            maxLines: 4,
            hint: tr('bio_hint'),
          ),
        ] else
          LabeledField(
            label: tr('address'),
            controller: _address,
            hint: tr('address_hint'),
          ),
      ],
      footer: PrimaryButton(
        label: tr('save_changes'),
        height: 48,
        radius: 10,
        style: almarai(14, weight: bold, color: Colors.white),
        onTap: _save,
      ),
    );
  }
}
