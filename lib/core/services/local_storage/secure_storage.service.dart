import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/services/local_storage/storage.dart';

final class SecureStorageService implements Storage {
  SecureStorageService._();

  static final SecureStorageService _instance = SecureStorageService._();
  static SecureStorageService get instance=> _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw ApiException(
        'SecureStorage write failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
@override
  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      throw ApiException(
        'SecureStorage read failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
@override
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw ApiException(
        'SecureStorage delete failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
@override
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw ApiException(
        'SecureStorage deleteAll failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
}
