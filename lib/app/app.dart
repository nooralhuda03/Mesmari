import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mesmari_shared/core/core.dart';

import 'app_router.dart';

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key, this.initialSettings});

  /// Overrides the first route (used by tests).
  final RouteSettings? initialSettings;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        LocaleController.instance,
        ThemeController.instance,
      ]),
      builder: (context, _) => MaterialApp(
        title: 'مسماري - المعلم',
        debugShowCheckedModeBanner: false,
        locale: LocaleController.instance.locale,
        supportedLocales: LocaleController.supported,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeController.instance.mode,
        onGenerateRoute: TeacherRouter.onGenerateRoute,
        onGenerateInitialRoutes: (_) => [
          TeacherRouter.onGenerateRoute(initialSettings ?? _initialSettings()),
        ],
      ),
    );
  }

  /// Debug builds on web can open any screen directly, e.g.
  /// `?screen=/reports` or `?screen=/home&lang=en`.
  static RouteSettings _initialSettings() {
    final params = kDebugMode
        ? Uri.base.queryParameters
        : const <String, String>{};
    return RouteSettings(
      name: params['screen'] ?? AppRoutes.login,
      arguments: int.tryParse(params['tab'] ?? ''),
    );
  }
}
