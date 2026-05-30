import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_project/app/routes/app_routes.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/features/auth/presentation/widgets/signup_form.dart';
import 'package:starter_project/shared/widgets/Misc/app_rich_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            100.h,
            Text(context.localizations.loginTitle, style: context.textTheme.headlineLarge),
            20.h,

            AuthForm(),
            30.h,
            AppRichText(
              spans: [
                AppTextSpan(text: context.localizations.dontHaveAccountText),
                AppTextSpan(
                  text: context.localizations.signup,
                  onTap: () {
                    context.pushNamed(AppRoutes.signup);
                  },
                  style: TextStyle(decoration: TextDecoration.none),
                ),
              ],
            ),

            20.h,
          ],
        ),
      ),
    );
  }
}
