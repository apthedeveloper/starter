import 'package:freezed_annotation/freezed_annotation.dart';

part 'api.state.freezed.dart';

@freezed
sealed class ApiState<T> with _$ApiState<T> {
  const ApiState._();

  const factory ApiState({
    @Default(false) bool isLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isLoadingMore,
    T? data,
    String? error,
  }) = _ApiState<T>;

  bool get hasNoData {
    final value = data;

    return value == null ||
        (value is List && value.isEmpty) ||
        (value is Map && value.isEmpty) ||
        (value is Set && value.isEmpty) ||
        (value is Iterable && value.isEmpty) ||
        (value is String && value.isEmpty);
  }

  bool get hasData => !hasNoData;

  bool get hasError => error != null;

  bool get isIdle =>
      !isLoading &&
      !isRefreshing &&
      !isLoadingMore;
}