import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_project/core/error/api_exception.dart';

Future<T> asyncUseCase<T>(Future<T> Function() action) async {
  try {
    return await action();

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

      case 'user-not-found':
        throw ApiException(
          'User not found',
          type: ApiErrorType.notFound,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'email-already-in-use':
        throw ApiException(
          'Email already in use',
          type: ApiErrorType.validation,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'weak-password':
        throw ApiException(
          'Weak password',
          type: ApiErrorType.validation,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'too-many-requests':
        throw ApiException(
          'Too many requests. Try again later.',
          type: ApiErrorType.tooManyRequests,
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

      case 'user-disabled':
        throw ApiException(
          'User account disabled',
          type: ApiErrorType.forbidden,
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
    switch (e.code) {
      case 'permission-denied':
        throw ApiException(
          'Permission denied',
          type: ApiErrorType.forbidden,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'not-found':
        throw ApiException(
          'Document not found',
          type: ApiErrorType.notFound,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'unavailable':
        throw ApiException(
          'Service unavailable',
          type: ApiErrorType.network,
          raw: e,
          stackTrace: stackTrace,
        );

      case 'deadline-exceeded':
        throw ApiException(
          'Request timeout',
          type: ApiErrorType.timeout,
          raw: e,
          stackTrace: stackTrace,
        );

      default:
        throw ApiException(
          e.message ?? 'Database error',
          type: ApiErrorType.server,
          raw: e,
          stackTrace: stackTrace,
        );
    }

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
  } on FormatException catch (e, stackTrace) {
    throw ApiException(
      'Invalid data format',
      type: ApiErrorType.validation,
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
