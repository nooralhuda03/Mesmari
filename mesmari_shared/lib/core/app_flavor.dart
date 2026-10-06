/// Which of the two apps this build is. Set once in `main()`.
abstract final class AppFlavor {
  static bool isTeacher = false;

  static String get appName => isTeacher ? 'مسماري - المعلم' : 'مسماري';
}
