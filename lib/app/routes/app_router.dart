import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/app/routes/app_routes.dart';
import 'package:starter_project/app/screens/main_navigation.screen.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';
import 'package:starter_project/core/utils/ensure_permission.dart';
import 'package:starter_project/features/auth/presentation/controller/auth.provider.dart';
import 'package:starter_project/features/auth/presentation/screens/complete_profile.screen.dart';
import 'package:starter_project/features/auth/presentation/screens/login.screen.dart';
import 'package:starter_project/features/auth/presentation/screens/signup.screen.dart';
import 'package:starter_project/features/auth/presentation/screens/splash.screen.dart';
import 'package:starter_project/features/auth/presentation/screens/verify_email.screen.dart';
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
          builder: (_, _) => CompleteProfileScreen(),
        ),

        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.home,
                  name: AppRoutes.home,
                  builder: (context, state) => QuickContainer(
                    color: AppColors.secondary,
                    child: Center(child: Text(AppRoutes.home)),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.search,
                  name: AppRoutes.search,
                  builder: (context, state) => QuickContainer(
                    color: AppColors.successLight,
                    child: Center(child: Text(AppRoutes.search)),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.explore,
                  name: AppRoutes.explore,
                  builder: (context, state) => SingleChildScrollView(
                    child: Column(
                      children: [
                        QuickContainer(
                          h: 60,
                          mb: 3,
                          onTap: () async {
                            ensurePermission(
                              context,
                              type: PermissionType.location,
                              grantedType: PermissionGrant.always,
                              onPermissionGet: () {},
                            );
                          },

                          color: AppColors.warningLight,
                          child: Center(
                            child: Text(PermissionType.location.toString()),
                          ),
                        ),
                        QuickContainer(
                          h: 60,
                          mb: 3,
                          onTap: () async {
                            ensurePermission(
                              context,
                              type: PermissionType.location,
                              grantedType: PermissionGrant.whenInUse,
                              onPermissionGet: () {},
                            );
                          },

                          color: AppColors.warningLight,
                          child: Center(child: Text("while in use")),
                        ),
                        ...PermissionType.values.map((e) {
                          return QuickContainer(
                            h: 60,
                            mb: 3,
                            onTap: () async {
                              ensurePermission(
                                context,
                                type: e,
                                onPermissionGet: () {},
                              );
                            },

                            color: AppColors.warningLight,
                            child: Center(child: Text(e.toString())),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profile,
                  name: AppRoutes.profile,
                  builder: (context, state) => QuickContainer(
                    color: AppColors.infoLight,
                    child: Center(child: Text(AppRoutes.profile)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],

      redirect: (context, state) {
        final authState = authStateNotifier.value;

        final user = authState.userState.data;
        final location = state.matchedLocation;

        AppLogger.d("REDIRECTING TO $location", tag: "REDIRECT");

        if (authState.isInitializing) {
          return location == AppRoutes.splash ? null : AppRoutes.splash;
        }

        if (location == AppRoutes.splash) {
          if (user == null) {
            return AppRoutes.login;
          }

          if (!user.isEmailVerified) {
            return AppRoutes.verifyEmail;
          }

          if (!user.isProfileComplete) {
            return AppRoutes.completeProfile;
          }

          return AppRoutes.home;
        }
        final isPublicRoute = [
          AppRoutes.login,
          AppRoutes.signup,
          AppRoutes.register,
          AppRoutes.forgotPassword,
          AppRoutes.resetPassword,
          AppRoutes.verifyOtp,
        ].contains(location);

        if (user == null) {
          return isPublicRoute ? null : AppRoutes.login;
        }

        if (!user.isEmailVerified) {
          return location == AppRoutes.verifyEmail
              ? null
              : AppRoutes.verifyEmail;
        }

        if (!user.isProfileComplete) {
          return location == AppRoutes.completeProfile
              ? null
              : AppRoutes.completeProfile;
        }

        if (location == AppRoutes.completeProfile) {
          return AppRoutes.home;
        }

        if (isPublicRoute) {
          return AppRoutes.home;
        }

        return null;
      },
    );

    return router;
  });
}
