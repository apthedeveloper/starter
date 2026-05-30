import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/constants/app_constants.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/layout/app_layout.dart';
import 'package:starter_project/core/extensions/string.extenstion.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/shared/widgets/Misc/app_rich_text.dart';
import 'package:starter_project/app/routes/app_routes.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  final resendSecondsNotifier = ValueNotifier<int>(0);
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authControllerProvider.notifier).sendVerificationEmail();
      startResendCooldown();
    });
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

  void startResendCooldown() {
    resendSecondsNotifier.value = AppConstants.resendSeconds;

    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSecondsNotifier.value <= 1) {
        timer.cancel();
        resendSecondsNotifier.value = 0;
        return;
      }

      resendSecondsNotifier.value--;
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _resendTimer?.cancel();
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
                child: QuickContainer(
                  w: 120,
                  h: 120,
                  color: context.colors.primary.withValues(alpha: 0.1),
                  shape: .circle,
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
                  context.localizations.checkYourEmail,
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
                  context.localizations.sentVerificationLink,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              6.h,

              // — Email address —
              Builder(
                builder: (context) {
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
                child: QuickContainer(
                  p: 16,
                  color: context.colors.infoLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: context.colors.info.withValues(alpha: 0.2),
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
                          context.localizations.checkInboxInstructions,
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
              ValueListenableBuilder<int>(
                valueListenable: resendSecondsNotifier,
                builder: (_, resendSeconds, _) {
                  final isLoading = ref.watch(
                    authControllerProvider.select((e) => e.secondaryLoader),
                  );

                  return AppButton(
                    text: resendSeconds == 0
                        ? context.localizations.resendEmail
                        : context.localizations.resendEmailWithSeconds(
                            resendSeconds,
                          ),
                    type: ButtonType.secondaryPrimary,
                    isLoading: isLoading,
                    onPressed: resendSeconds != 0
                        ? null
                        : () {
                            ref
                                .read(authControllerProvider.notifier)
                                .sendVerificationEmail();
                            startResendCooldown();
                          },
                  );
                },
              ),

              12.h,

              // — Continue button (after email verified) —
              Builder(
                builder: (_) {
                  final isLoading = ref.watch(
                    authControllerProvider.select((e) => e.userState.isLoading),
                  );

                  return AppButton(
                    text: context.localizations.continueBtn,
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
                      AppTextSpan(text: context.localizations.wrongEmailText),
                      AppTextSpan(
                        text: context.localizations.goBack,
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
