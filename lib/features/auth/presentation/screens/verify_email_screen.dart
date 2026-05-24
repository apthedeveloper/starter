import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/layout/app_layout.dart';
import 'package:starter_project/core/extensions/string.extenstion.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/shared/services/app_launcher_services.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/shared/widgets/Misc/app_rich_text.dart';
import 'package:starter_project/app/routes/app_routes.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppLayout.horizontalEdgeInsets(context),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // — Animated icon —
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: context.colors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mark_email_unread_rounded,
                    size: 56,
                    color: context.colors.primary,
                  ),
                ),
              ),

              32.h,

              // — Title —
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Check Your Email',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              12.h,

              // — Subtitle —
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'We\'ve sent a verification link to',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              6.h,

              // — Email address —
              Consumer(
                builder: (context, ref, child) {
                  final email =
                      ref.read(authControllerProvider).userState.data?.email ??
                      '';
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      email.masked(type: MaskType.email),
                      // _maskedEmail,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),

              24.h,

              // — Info box —
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.infoLight.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colors.info.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: context.colors.info,
                        size: 22,
                      ),
                      12.w,
                      Expanded(
                        child: Text(
                          'Please check your inbox and tap the verification link to continue.',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurface,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // — Resend email button —
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(
                    authControllerProvider.select((e) => e.secondaryLoader),
                  );

                  return AppButton(
                    text: 'Resend Email',
                    type: ButtonType.secondaryPrimary,
                    isLoading: isLoading,
                    onPressed: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .sendVerificationEmail();
                    },
                  );
                },
              ),

              12.h,

              // — Continue button (after email verified) —
              Consumer(
                builder: (context, ref, child) {
                  final isLoading = ref.watch(
                    authControllerProvider.select((e) => e.userState.isLoading),
                  );

                  return AppButton(
                    text: 'Continue',
                    isLoading: isLoading,
                    onPressed: () async {
                      final isVerified = await ref
                          .read(authControllerProvider.notifier)
                          .continueAfterEmailVerification();

                      if (isVerified && context.mounted) {
                        context.goNamed(AppRoutes.completeProfile);
                      }
                    },
                  );
                },
              ),

              20.h,

              // — Back to login —
              Consumer(
                builder: (context, ref, child) {
                  return AppRichText(
                    spans: [
                      AppTextSpan(text: 'Wrong email? '),
                      AppTextSpan(
                        text: 'Go Back',
                        onTap: () {
                          ref.read(authControllerProvider.notifier).logout();
                        },
                        style: const TextStyle(decoration: TextDecoration.none),
                      ),
                    ],
                  );
                },
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
