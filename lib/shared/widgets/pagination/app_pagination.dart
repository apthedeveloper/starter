import 'package:flutter/material.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/shared/states/pagination_state.dart';

class AppPagination<T> extends StatefulWidget {
  final PaginationState<T> state;

  final Widget Function(
    ScrollController controller,
    IndexedWidgetBuilder itemBuilder,
    int itemCount,
  )
  builder;

  final Widget Function(BuildContext, T, int) itemBuilder;

  final WidgetBuilder? initialLoaderBuilder;
  final WidgetBuilder? emptyBuilder;
  final WidgetBuilder? loadMoreBuilder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? loadMoreErrorBuilder;
  final WidgetBuilder? noMoreDataBuilder;

  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;

  const AppPagination({
    super.key,
    required this.state,
    required this.builder,
    required this.itemBuilder,
    this.initialLoaderBuilder,
    this.emptyBuilder,
    this.loadMoreBuilder,
    this.noMoreDataBuilder,
    this.errorBuilder,
    this.loadMoreErrorBuilder,
    this.onRefresh,
    this.onLoadMore,
  });

  @override
  State<AppPagination<T>> createState() => _AppPaginationState<T>();
}

class _AppPaginationState<T> extends State<AppPagination<T>> {
  final ScrollController _controller = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant AppPagination<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAndLoadMoreIfNeeded();
  }

  void _onScroll() async {
    if (!_controller.hasClients) return;

    final position = _controller.position;

    if (position.maxScrollExtent <= 0) return;

    if (position.pixels >=
        position.maxScrollExtent - position.viewportDimension * 0.2) {
      await _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isFetchingMore || widget.state.isLoading || widget.state.isLastPage) {
      return;
    }
    try {
      _isFetchingMore = true;
      await widget.onLoadMore?.call();
    } finally {
      _isFetchingMore = false;
    }
  }

  void _checkAndLoadMoreIfNeeded() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_controller.hasClients) return;

      final position = _controller.position;

      if (position.maxScrollExtent <= 0) {
        await _loadMore();
      }
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final state = widget.state;

    if (index < state.items.length) {
      return widget.itemBuilder(context, state.items[index], index);
    }

    /// Footer
    if (state.hasLoadMoreError) {
      return widget.loadMoreErrorBuilder?.call(context) ??
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: Text(context.localizations.failedToLoadMore)),
          );
    }

    if (state.isLastPage) {
      return widget.noMoreDataBuilder?.call(context) ?? const SizedBox.shrink();
    }

    return widget.loadMoreBuilder?.call(context) ??
        widget.initialLoaderBuilder?.call(context) ??
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    /// Initial Loading
    if (state.items.isEmpty && state.isLoading) {
      return widget.initialLoaderBuilder?.call(context) ??
          const Center(child: CircularProgressIndicator());
    }

    /// Error
    if (state.items.isEmpty && state.hasError) {
      return widget.errorBuilder?.call(context) ??
          Center(child: Text(context.localizations.somethingWentWrong));
    }

    /// Empty
    if (state.items.isEmpty) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh ?? () async {},
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SizedBox(
              child: Center(
                child:
                    widget.emptyBuilder?.call(context) ??
                    Text(context.localizations.noDataFound),
              ),
            ),
          ],
        ),
      );
    }

    /// Main Builder  (List / Grid / Anything)
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: widget.builder(_controller, _itemBuilder, state.items.length + 1),
    );
  }
}
