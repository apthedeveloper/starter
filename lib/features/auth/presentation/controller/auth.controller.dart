import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/core/network/json_keys.dart';
import 'package:starter_project/features/auth/domain/entities/user.entity.dart';
import 'package:starter_project/features/auth/domain/repositories/auth.repository.dart';
import 'package:starter_project/features/auth/domain/usecases/complete_profile.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/login.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/logout.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/refresh_current_user.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/send_verification_email.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/signup.usecase.dart';
import 'package:starter_project/features/auth/domain/usecases/start_listen.usecase.dart';
import 'package:starter_project/features/auth/presentation/state/auth.state.dart';
import 'package:starter_project/gen/app_localizations_en.dart';
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
            : AppLocalizationsEn().somethingWentWrong;

        AppSnackbar.error(message);

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
      AppSnackbar.error(e.message);

      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );

      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      final message = isSignup
          ? AppLocalizationsEn().signupFailed
          : AppLocalizationsEn().loginFailed;

      AppSnackbar.error(message);

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
    state = state.copyWith(secondaryLoader: true);
    try {
      await SendVerificationEmailUseCase(repo).call();
      AppSnackbar.success(AppLocalizationsEn().verificationEmailSent);
    } on ApiException catch (e) {
      AppSnackbar.error(e.message);
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.error(AppLocalizationsEn().failedToSendVerificationEmail);
      AppLogger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      state = state.copyWith(secondaryLoader: false);
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
      AppSnackbar.error(e.message);
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.error(AppLocalizationsEn().failedToRefreshCurrentUser);
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
        AppSnackbar.error(AppLocalizationsEn().failedToLogout);
      }
    } on ApiException catch (e) {
      AppSnackbar.error(e.message);
      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );
      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.error(AppLocalizationsEn().failedToRefreshCurrentUser);
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
      AppSnackbar.warning(AppLocalizationsEn().pleaseVerifyYourEmailFirst);
      return false;
    }

    return true;
  }

  Future<void> completeProfile({
    required String name,
    required String bio,
    required String dateOfBirth,
    required String gender,
    required String profileImagePath,
  }) async {
    state = state.copyWith(
      userState: state.userState.copyWith(isLoading: true, error: null),
    );

    try {
      final profileData = <String, dynamic>{
        JsonKeys.name: name,
        JsonKeys.bio: bio,
        JsonKeys.dateOfBirth: dateOfBirth,
        JsonKeys.gender: gender,
        JsonKeys.profileImagePath: profileImagePath,
      };

      await CompleteProfileUseCase(
        repo,
      ).call(data: profileData, profileLocalPath: profileImagePath);

      AppSnackbar.success(AppLocalizationsEn().profileCompletedSuccessfully);
    } on ApiException catch (e) {
      AppSnackbar.error(e.message);

      state = state.copyWith(
        userState: state.userState.copyWith(error: e.message),
      );

      AppLogger.e(e.message, error: e, stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      AppSnackbar.error(AppLocalizationsEn().failedToCompleteProfile);

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
}
