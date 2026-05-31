import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

Future<T> asyncUseCase<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on FirebaseAuthException catch (e, stackTrace) {
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        throw ApiException(
          AppLocalizationsEn().invalidEmailOrPassword,
          type: ApiErrorType.unauthorized,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'user-not-found':
        throw ApiException(
          AppLocalizationsEn().userNotFound,
          type: ApiErrorType.notFound,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'email-already-in-use':
        throw ApiException(
          AppLocalizationsEn().emailAlreadyInUse,
          type: ApiErrorType.validation,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'weak-password':
        throw ApiException(
          AppLocalizationsEn().weakPassword,
          type: ApiErrorType.validation,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'too-many-requests':
        throw ApiException(
          AppLocalizationsEn().tooManyRequestsTryAgainLater,
          type: ApiErrorType.tooManyRequests,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'network-request-failed':
        throw ApiException(
          AppLocalizationsEn().noInternetConnection,
          type: ApiErrorType.network,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'user-disabled':
        throw ApiException(
          AppLocalizationsEn().userAccountDisabled,
          type: ApiErrorType.forbidden,
          raw: e,
          stackTrace: stackTrace,
        );

      default:
        throw ApiException(
          e.message ?? AppLocalizationsEn().authenticationFailed,
          type: ApiErrorType.server,
          raw: e,
          stackTrace: stackTrace,
        );
    }
  } on FirebaseException catch (e, stackTrace) {
    switch (e.code) {
      case 'permission-denied':
        throw ApiException(
          AppLocalizationsEn().permissionDenied,
          type: ApiErrorType.forbidden,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'not-found':
        throw ApiException(
          AppLocalizationsEn().documentNotFound,
          type: ApiErrorType.notFound,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'unavailable':
        throw ApiException(
          AppLocalizationsEn().serviceUnavailable,
          type: ApiErrorType.network,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'deadline-exceeded':
        throw ApiException(
          AppLocalizationsEn().requestTimeout,
          type: ApiErrorType.timeout,
          raw: e,
          stackTrace: stackTrace,
        );

      default:
        throw ApiException(
          e.message ?? AppLocalizationsEn().databaseError,
          type: ApiErrorType.server,
          raw: e,
          stackTrace: stackTrace,
        );
    }
  } on SocketException catch (e, stackTrace) {
    throw ApiException(
      AppLocalizationsEn().noInternetConnection,
      type: ApiErrorType.network,
      raw: e,
      stackTrace: stackTrace,
    );
  } on TimeoutException catch (e, stackTrace) {
    throw ApiException(
      AppLocalizationsEn().requestTimeout,
      type: ApiErrorType.timeout,
      raw: e,
      stackTrace: stackTrace,
    );
  } on FormatException catch (e, stackTrace) {
    throw ApiException(
      AppLocalizationsEn().invalidDataFormat,
      type: ApiErrorType.validation,
      raw: e,
      stackTrace: stackTrace,
    );
  } on ApiException {
    rethrow;
  } catch (e, stackTrace) {
    throw ApiException(
      AppLocalizationsEn().somethingWentWrong,
      type: ApiErrorType.unknown,
      raw: e,
      stackTrace: stackTrace,
    );
  }
}
