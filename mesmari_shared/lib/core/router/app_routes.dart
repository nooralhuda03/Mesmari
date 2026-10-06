/// Route names shared by both apps. Each app's router implements the
/// routes it actually has.
abstract final class AppRoutes {
  // Auth
  static const login = '/login';
  static const otp = '/otp'; // arguments: OtpArgs
  static const signup = '/signup';
  static const home = '/home'; // the app's tab shell

  // Shared
  static const notificationCenter = '/notifications';
  static const notificationSettings = '/settings/notifications';
  static const language = '/settings/language';
  static const appearance = '/settings/appearance';
  static const editProfile = '/profile/edit';
  static const profile = '/profile';
  static const chatList = '/chat';
  static const chat = '/chat/thread'; // arguments: String conversation id
  static const liveMeeting = '/meeting'; // arguments: LiveMeetingArgs
  static const videoPlayer = '/player'; // arguments: PlayerArgs
  static const pdfViewer = '/document'; // arguments: DocArgs

  // Student app
  static const courseDetails = '/course';
  static const lesson = '/lesson';
  static const quiz = '/quiz';
  static const quizResult = '/quiz/result'; // arguments: QuizResultArgs
  static const certificate = '/certificate';
  static const shareCertificate = '/certificate/share';

  // Teacher app
  static const courseManage = '/course/manage'; // arguments: String title
  static const newCourse = '/course/new';
  static const assignCourse = '/course/students'; // arguments: String title
  static const lectureEdit = '/lecture/edit'; // arguments: ManagedLecture?
  static const quizEditor = '/quiz/edit'; // arguments: String lecture title
  static const teacherMeetings = '/meetings';
  static const scheduleMeeting = '/meetings/new';
  static const reports = '/reports';
  static const earnings = '/earnings';
  static const sendReminder = '/reminder'; // arguments: String student name
}
