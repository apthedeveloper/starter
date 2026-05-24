import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_project/app/routes/app_routes.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/features/auth/presentation/widgets/signup_form.dart';
import 'package:starter_project/shared/widgets/Misc/app_rich_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            100.h,
            Text("Sign Up", style: context.textTheme.headlineLarge),
            20.h,

            AuthForm(isSignup: true),
            30.h,
            AppRichText(
              spans: [
                AppTextSpan(text: "If you have any account"),
                AppTextSpan(
                  text: "Login",
                  onTap: () {
                    context.pushNamed(AppRoutes.login);
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
