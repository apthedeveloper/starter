class ApiState<T> {
  final bool isLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final T? data;
  final String? error;

  const ApiState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.data,
    this.error,
  });

  bool get hasNoData =>
      data == null ||
      (data is List && (data as List).isEmpty) ||
      (data is Map && (data as Map).isEmpty ||
          (data is Set && (data as Set).isEmpty) ||
          (data is Iterable && (data as Iterable).isEmpty) ||
          (data is String && (data as String).isEmpty));

  ApiState<T> copyWith({
    bool? isLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    T? data,
    String? error,
  }) {
    return ApiState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      data: data ?? this.data,
      error: error,
    );
  }
}
