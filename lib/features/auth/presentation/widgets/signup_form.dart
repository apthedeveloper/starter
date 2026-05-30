import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/layout/app_layout.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/shared/controllers/selection.controller.dart';
import 'package:starter_project/core/utils/validators.dart';
import 'package:starter_project/shared/widgets/inputs/app_input_label.dart';
import 'package:starter_project/shared/widgets/inputs/app_text_field.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';

class AuthForm extends StatefulWidget {
  final bool isSignup;
  const AuthForm({super.key,  this.isSignup=false});
  

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final controller = SelectionController<String>([]);
  final dropdownFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppLayout.horizontalEdgeInsets(context),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFieldLabel(text: context.localizations.emailLabel),
            2.h,
            AppTextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: context.localizations.emailHint,
                prefixIcon: Icon(Icons.email),
              ),
              autofillHints: [AutofillHints.email],
              validator: (value) => Validators.email(context, value),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
            ),
            8.h,

            AppFieldLabel(text: context.localizations.passwordLabel),
            2.h,

            AppTextField(
              controller: passwordController,
              type: AppTextFieldType.password,
              decoration: InputDecoration(
                hintText: context.localizations.passwordHint,
                prefixIcon: Icon(Icons.lock),
              ),
              textInputAction: TextInputAction.done,
              autofillHints: [AutofillHints.password],
              validator: (value) => Validators.password(context, value),
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
            ),

            40.h,

            Consumer(
              builder: (context, ref, child) {
                final isLoading = ref.watch(
                  authControllerProvider.select((s) => s.userState.isLoading),
                );
                return AppButton(
                  text: widget.isSignup ? context.localizations.signup : context.localizations.login,
                  isLoading: isLoading,
                  onPressed: () async {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    ref
                        .read(authControllerProvider.notifier)
                        .login(
                          email: emailController.text,
                          password: passwordController.text,
                          isSignup: widget.isSignup,
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
