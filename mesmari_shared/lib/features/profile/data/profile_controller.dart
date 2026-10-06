import 'package:flutter/foundation.dart';
import 'package:mesmari_shared/core/app_flavor.dart';
import 'package:mesmari_shared/core/l10n/app_strings.dart';

/// The signed-in user's editable details.
@immutable
class UserProfile {
  const UserProfile({
    required this.name,
    required this.phone,
    this.address = '',
    this.headline = '',
    this.bio = '',
  });

  final String name;
  final String phone;
  final String address;
  final String headline;
  final String bio;

  UserProfile copyWith({
    String? name,
    String? phone,
    String? address,
    String? headline,
    String? bio,
  }) => UserProfile(
    name: name ?? this.name,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    headline: headline ?? this.headline,
    bio: bio ?? this.bio,
  );

  /// Seeded values hold a translation key; a name the user typed
  /// passes through unchanged.
  String get displayName => tr(name);

  String get displayAddress => tr(address);

  String get displayHeadline => tr(headline);

  String get displayBio => tr(bio);

  String get initials => initialsOf(displayName);

  /// First letters of the first and last word, e.g. "نور الهدى اسعد" -> "ن ا".
  static String initialsOf(String name) {
    final words = name
        .split(' ')
        .map((w) => w.trim())
        .where((w) => w.length > 1)
        .toList();
    if (words.isEmpty) return '؟';
    if (words.length == 1) return words.first.substring(0, 1);
    return '${words.first.substring(0, 1)} ${words.last.substring(0, 1)}';
  }
}

/// The signed-in user of this app, kept in memory. Swap for your state
/// manager (or a backend call) when the API is ready.
class ProfileController extends ChangeNotifier {
  ProfileController._();

  static final ProfileController instance = ProfileController._();

  // Seeded values are translation keys; [UserProfile.displayName] resolves
  // them, and a name typed by the user passes through unchanged.
  static const _studentDefault = UserProfile(
    name: 'c_student_me',
    phone: '07XXXXXXXXX',
    address: 'c_address_baghdad',
  );

  static const _teacherDefault = UserProfile(
    name: 'c_teacher_sara',
    phone: '07XXXXXXXXX',
    headline: 'c_headline_programming',
    bio: 'c_bio_sara',
  );

  UserProfile _profile = AppFlavor.isTeacher
      ? _teacherDefault
      : _studentDefault;

  /// Stable id of the signed-in user — never translated.
  String get userId => AppFlavor.isTeacher ? 'teacher-1' : 'student-1';

  UserProfile get profile => _profile;

  void save(UserProfile value) {
    _profile = value;
    notifyListeners();
  }

  void setName(String name) => save(_profile.copyWith(name: name));

  void setPhone(String phone) => save(_profile.copyWith(phone: phone));
}
