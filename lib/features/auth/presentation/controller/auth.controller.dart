import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/features/auth/domain/usecases/login.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/logout.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/refresh_current_user.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/send_verification_email.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/signup.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/start_listen.usecase.dart';
import 'package:starter_project/features/auth/presentation/state/auth.state.dart';
import 'package:starter_project/shared/states/api.state.dart';
import 'package:starter_project/shared/widgets/feedbacks/app_snackbar.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository repo;
  StreamSubscription<User?>? _subscription;

  AuthController(this.repo) : super(AuthState(userState: ApiState()));

  Future<void> startListening() async {
    _subscription?.cancel();
    _subscription = null;

    state = state.copyWith(
      userState: state.userState.copyWith(isLoading: true, error: null),
    );

    // await RefreshCurrentUserUseCase(repo).call();

    _subscription = StartListenUserStateChangesUseCase(repo).call().listen(
      (user) {
        state = state.copyWith(
          userState: state.userState.copyWith(
            data: user,
            isLoading: false,
            error: null,
          ),
        );
      },
      onError: (error, stackTrace) {
        final message = error is ApiException
            ? error.message
            : "Something went wrong";

        AppSnackbar.show(message: message, type: SnackbarType.error);

        state = state.copyWith(
          userState: state.userState.copyWith(error: message, isLoading: false),
        );

        AppLogger.e(message, error: error, stackTrace: stackTrace);
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> initializeApp({Future<void> Function()? callback}) async {
    state = state.copyWith(isInitializing: true);

    await startListening();
    await callback?.call();
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(isInitializing: false);
  }

  Future<void> login({
    required String email,
    required String password,
    bool isSignup = false,
  }) async {
    state = state.copyWith(
      userState: state.userState.copyWith(isLoading: true, error: null),
    );

    try {
      if (isSignup) {
        await SignupUseCase(repo).call(email: email, password: password);
      } else {
        await LoginUseCase(repo).call(email: email, password: password);
      }
    } on ApiException catch (e) {
      AppSnackbar.show(message: e.message, type: SnackbarType.error);

      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );

      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      final message = isSignup ? "Signup failed" : "Login failed";

      AppSnackbar.show(message: message, type: SnackbarType.error);

      state = state.copyWith(
        userState: state.userState.copyWith(error: e.toString()),
      );

      AppLogger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      state = state.copyWith(
        userState: state.userState.copyWith(isLoading: false, error: null),
      );
    }
  }

  Future<void> sendVerificationEmail() async {
    state = state.copyWith(otherLoader: true);
    try {
      await SendVerificationEmailUseCase(repo).call();
      AppSnackbar.show(
        message: "Verification email sent",
        type: SnackbarType.success,
      );
    } on ApiException catch (e) {
      AppSnackbar.show(message: e.message, type: SnackbarType.error);
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.show(
        message: "Failed to send verification email",
        type: SnackbarType.error,
      );
      AppLogger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      state = state.copyWith(otherLoader: false);
    }
  }

  Future<void> refreshCurrentUser() async {
    state = state.copyWith(
      userState: state.userState.copyWith(isLoading: true),
    );
    try {
      final user = await RefreshCurrentUserUseCase(repo).call();
      state = state.copyWith(userState: state.userState.copyWith(data: user));
    } on ApiException catch (e) {
      AppSnackbar.show(message: e.message, type: SnackbarType.error);
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.show(
        message: "Failed to refresh current user",
        type: SnackbarType.error,
      );
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.toString()),
      );
      AppLogger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      state = state.copyWith(
        userState: state.userState.copyWith(isLoading: false, error: null),
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(
      userState: state.userState.copyWith(isLoading: true),
    );
    try {
      final isSuccess = await LogoutUseCase(repo).call();
      if (!isSuccess) {
        AppSnackbar.show(message: "Failed to logout", type: SnackbarType.error);
      }
    } on ApiException catch (e) {
      AppSnackbar.show(message: e.message, type: SnackbarType.error);
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.show(
        message: "Failed to refresh current user",
        type: SnackbarType.error,
      );
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.toString()),
      );
      AppLogger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      state = state.copyWith(
        userState: state.userState.copyWith(isLoading: false, error: null),
      );
    }
  }

  Future<bool> continueAfterEmailVerification() async {
    await refreshCurrentUser();
    final isEmailVerified = state.userState.data?.isEmailVerified ?? false;

    if (!isEmailVerified) {
      AppSnackbar.show(
        message: "Please verify your email first",
        type: SnackbarType.warning,
      );
      return false;
    }

    return true;
  }
}
