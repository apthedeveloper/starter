import 'package:flutter/material.dart';
import 'package:starter_project/app/layout/app_layout.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/features/auth/presentation/widgets/profile_form.dart';
import 'package:starter_project/shared/widgets/sections/app_appbar.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar.modal(title: context.localizations.completeProfileTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppLayout.screenPadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [20.h, ProfileForm(), 30.h],
            ),
          ),
        ),
      ),
    );
  }
}
