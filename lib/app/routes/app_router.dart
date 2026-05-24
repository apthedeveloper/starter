import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_project/app/routes/app_routes.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/features/auth/presentation/screens/login_screen.dart';
import 'package:starter_project/features/auth/presentation/screens/signup_screen.dart';
import 'package:starter_project/features/auth/presentation/screens/splash_screen.dart';
import 'package:starter_project/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:starter_project/features/auth/presentation/state/auth.state.dart';

final class AppRouter {
  AppRouter._();
  static final goRouterProvider = Provider<GoRouter>((ref) {
    final authStateNotifier = ValueNotifier<AuthState>(
      ref.read(authControllerProvider),
    );

    ref.listen(authControllerProvider, (prev, next) {
      authStateNotifier.value = next;
    });

    final router = GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: authStateNotifier,
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          name: AppRoutes.splash,
          builder: (_, _) => const SplashScreen(),
        ),

        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.login,
          builder: (_, _) => LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.signup,
          name: AppRoutes.signup,
          builder: (_, _) => SignupScreen(),
        ),
        GoRoute(
          path: AppRoutes.verifyEmail,
          name: AppRoutes.verifyEmail,
          builder: (_, _) => VerifyEmailScreen(),
        ),
        GoRoute(
          path: AppRoutes.completeProfile,
          name: AppRoutes.completeProfile,
          builder: (_, _) => Container(color: Colors.greenAccent),
        ),
      ],

      redirect: (context, state) {
        final user = authStateNotifier.value.userState.data;

        final location = state.matchedLocation;

        if(authStateNotifier.value.isInitializing) return AppRoutes.splash;


        final isAuthRoute = [
          AppRoutes.login,
          AppRoutes.signup,
          AppRoutes.register,
          AppRoutes.forgotPassword,
          AppRoutes.resetPassword,
          AppRoutes.verifyOtp,
        ].contains(location);

        if (user == null) {
          if (isAuthRoute) return null;

          return AppRoutes.login;
        }

        if (!user.isEmailVerified) {
          if (location == AppRoutes.verifyEmail) {
            return null;
          }
          

          return AppRoutes.verifyEmail;
        }

        if (!user.isProfileComplete) {
          if (location == AppRoutes.completeProfile) return null;

          return AppRoutes.completeProfile;
        }

        if (isAuthRoute) {
          return AppRoutes.home;
        }

        return null;
      },
    );

    return router;
  });
}
