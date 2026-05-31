import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/gen/app_localizations_en.dart';

Stream<T> streamUseCase<T>(Stream<T> Function() action) async* {
  try {
    yield* action();
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

      case 'network-request-failed':
        throw ApiException(
          AppLocalizationsEn().noInternetConnection,
          type: ApiErrorType.network,
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
    throw ApiException(
      e.message ?? AppLocalizationsEn().databaseError,
      type: ApiErrorType.server,
      raw: e,
      stackTrace: stackTrace,
    );
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
