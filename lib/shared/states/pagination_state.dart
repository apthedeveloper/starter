import 'package:cloud_firestore/cloud_firestore.dart';

class PaginationState<T> {
  final List<T> items;
  final DocumentSnapshot<Map<String, dynamic>>? lastSnapshot;
  final bool isLoading;
  final bool isLastPage;
  final bool hasError;
  final bool hasLoadMoreError;

  const PaginationState({
    required this.items,
    required this.isLoading,
    required this.isLastPage,
    this.lastSnapshot,
    this.hasError = false,
    this.hasLoadMoreError = false,
  });

  PaginationState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? isLastPage,
    bool? hasError,
    bool? hasLoadMoreError,
    DocumentSnapshot<Map<String, dynamic>>? lastSnapshot,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      hasError: hasError ?? this.hasError,
      hasLoadMoreError: hasLoadMoreError ?? this.hasLoadMoreError,
      lastSnapshot: lastSnapshot ?? this.lastSnapshot,
    );
  }
}
