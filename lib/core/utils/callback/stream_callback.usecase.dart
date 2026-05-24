import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_project/core/error/api_exception.dart';

Stream<T> streamUseCase<T>(Stream<T> Function() action) async* {
  try {
    yield* action();

  } on FirebaseAuthException catch (e, stackTrace) {
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        throw ApiException(
          'Invalid email or password',
          type: ApiErrorType.unauthorized,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'network-request-failed':
        throw ApiException(
          'No internet connection',
          type: ApiErrorType.network,
          raw: e,
          stackTrace: stackTrace,
        );

      default:
        throw ApiException(
          e.message ?? 'Authentication failed',
          type: ApiErrorType.server,
          raw: e,
          stackTrace: stackTrace,
        );
    }

  } on FirebaseException catch (e, stackTrace) {
    throw ApiException(
      e.message ?? 'Database error',
      type: ApiErrorType.server,
      raw: e,
      stackTrace: stackTrace,
    );

  } on SocketException catch (e, stackTrace) {
    throw ApiException(
      'No internet connection',
      type: ApiErrorType.network,
      raw: e,
      stackTrace: stackTrace,
    );

  } on TimeoutException catch (e, stackTrace) {
    throw ApiException(
      'Request timeout',
      type: ApiErrorType.timeout,
      raw: e,
      stackTrace: stackTrace,
    );

  } on ApiException {
    rethrow;

  } catch (e, stackTrace) {
    throw ApiException(
      'Something went wrong',
      type: ApiErrorType.unknown,
      raw: e,
      stackTrace: stackTrace,
    );
  }
}