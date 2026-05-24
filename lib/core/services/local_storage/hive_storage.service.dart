import 'package:hive/hive.dart';
import 'package:starter_project/core/error/api_exception.dart';
import 'package:starter_project/core/services/local_storage/storage.dart';

final class HiveStorageService implements Storage {
  HiveStorageService._();

  static final HiveStorageService _instance = HiveStorageService._();
  static HiveStorageService get instance => _instance;

  static const String _boxName = 'app_storage';

  Future<Box> get _box async => await Hive.openBox(_boxName);

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      final box = await _box;
      await box.put(key, value);
    } catch (e) {
      throw ApiException(
        'Hive write failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<String?> read(String key) async {
    try {
      final box = await _box;
      return box.get(key) as String?;
    } catch (e) {
      throw ApiException(
        'Hive read failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<void> delete(String key) async {
    try {
      final box = await _box;
      await box.delete(key);
    } catch (e) {
      throw ApiException(
        'Hive delete failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }

  @override
  Future<void> deleteAll() async {
    try {
      final box = await _box;
      await box.clear();
    } catch (e) {
      throw ApiException(
        'Hive deleteAll failed',
        raw: e,
        stackTrace: StackTrace.current,
        type: ApiErrorType.unknown,
      );
    }
  }
}
