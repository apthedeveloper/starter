import 'package:flutter/material.dart';
import 'package:starter_project/app/routes/app_router.dart';
import 'package:starter_project/app/core/services/feedback_services.dart';
import 'package:starter_project/app/theme/app_theme.dart';
import 'package:starter_project/bootstrap/env.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Env.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      scaffoldMessengerKey: FeedbackService.messengerKey,
    );
  }
}
