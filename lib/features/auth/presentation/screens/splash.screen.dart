import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _contentController;
  late final AnimationController _shimmerController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<double> _loaderFade;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(authControllerProvider.notifier).initializeApp();
    });

    // Logo entrance animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    );

    // Staggered content animation
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _titleFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _contentController,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
          ),
        );

    _subtitleFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );

    _loaderFade = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    // Shimmer loop for the logo ring
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Start the animation sequence
    _logoController.forward().then((_) {
      _contentController.forward();
      _shimmerController.repeat();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _contentController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuickContainer(
        w: double.infinity,
        h: double.infinity,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.85),
            Color.lerp(context.colors.primary, context.colors.secondary, 0.4) ??
                context.colors.primary,
          ],
        ),

        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),

              // — Animated logo —
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: _buildLogoWidget(context),
                ),
              ),

              40.h,

              // — App title —
              SlideTransition(
                position: _titleSlide,
                child: FadeTransition(
                  opacity: _titleFade,
                  child: Text(
                    context.localizations.appNameSplash,
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              8.h,

              // — Tagline —
              FadeTransition(
                opacity: _subtitleFade,
                child: Text(
                  context.localizations.tagline,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // — Loading indicator —
              FadeTransition(
                opacity: _loaderFade,
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ),

              40.h,

              // — Footer —
              FadeTransition(
                opacity: _subtitleFade,
                child: Text(
                  '© ${DateTime.now().year}',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),

              24.h,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoWidget(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return QuickContainer(
          w: 120,
          h: 120,
          shape: .circle,
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.2 + 0.15 * _shimmerController.value,
            ),
            width: 2.5,
          ),
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: context.colors.secondary.withValues(
                alpha: 0.15 * (1 - _shimmerController.value),
              ),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
          child: QuickContainer(
            shape: .circle,
            color: Colors.white.withValues(alpha: 0.15),
            child: const Icon(
              Icons.rocket_launch_rounded,
              size: 52,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
