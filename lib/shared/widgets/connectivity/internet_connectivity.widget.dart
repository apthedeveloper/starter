import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';
import 'package:starter_project/core/constants/app_durations.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/controller/internet_connectivity/internet_connectivity.provider.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:flutter/services.dart'; // Added for HapticFeedback

class NoInternetBanner extends ConsumerStatefulWidget {
  const NoInternetBanner({super.key});

  @override
  ConsumerState<NoInternetBanner> createState() => _NoInternetBannerState();
}

class _NoInternetBannerState extends ConsumerState<NoInternetBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation; // Changed to Offset
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: AppDurations.medium,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isConnected = ref.read(connectivityControllerProvider);
      if (!isConnected) {
        _controller.value = 1.0;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(connectivityControllerProvider, (previous, isConnected) {
      if (!isConnected) {
        _controller.forward();
        HapticFeedback.mediumImpact();
      } else {
        _controller.reverse();
      }
    });

    return AnimatedBuilder(
      animation: _controller,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            elevation: 8,
            color: AppColors.transparent,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSpacing.md),
              topRight: Radius.circular(AppSpacing.md),
            ),
            child: QuickContainer(
              w: double.infinity,
              px: AppSpacing.xl,
              py: AppSpacing.md,
              color: context.colors.error,
              radiusBL: AppSpacing.md,
              radiusBR: AppSpacing.md,
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: context.colors.surface,
                      size: 20,
                      weight: 1.3,
                    ),
                    16.w,
                    Expanded(
                      child: Text(
                        context.localizations.noInternetConnection,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.surface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      builder: (context, child) {
        if (_controller.value == 0.0 &&
            ref.watch(connectivityControllerProvider)) {
          return const SizedBox.shrink();
        }
        return child!;
      },
    );
  }
}
