import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/services/local_storage/storage.dart';

final class PrefsStorageService implements Storage {
  PrefsStorageService._();

  static final PrefsStorageService _instance = PrefsStorageService._();
  static PrefsStorageService get instance => _instance;

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      final prefs = await _prefs;
      await prefs.setString(key, value);
    } catch (e) {
      throw ApiException(
        'Prefs write failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getString(key);
    } catch (e) {
      throw ApiException(
        'Prefs read failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final prefs = await _prefs;
      await prefs.remove(key);
    } catch (e) {
      throw ApiException(
        'Prefs delete failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      final prefs = await _prefs;
      await prefs.clear();
    } catch (e) {
      throw ApiException(
        'Prefs deleteAll failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
} 