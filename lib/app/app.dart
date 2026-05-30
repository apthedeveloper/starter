import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/app/routes/app_router.dart';
import 'package:starter_project/core/config/config.dart';
import 'package:starter_project/shared/services/feedback_services.dart';
import 'package:starter_project/app/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_project/gen/app_localizations.dart';


class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(AppRouter.goRouterProvider);
    return MaterialApp.router(
      title: AppEnvironment.config.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      scaffoldMessengerKey: FeedbackService.messengerKey,
      localizationsDelegates: const [
        AppLocalizations.delegate,

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('en'),],
    );
  }
}
