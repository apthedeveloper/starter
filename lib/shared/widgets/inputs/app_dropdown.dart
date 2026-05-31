import 'package:flutter/material.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/textstyle_extenstion.dart';
import 'package:starter_project/shared/controllers/selection.controller.dart';
import 'package:starter_project/shared/models/selectable_item.dart';
import 'package:starter_project/shared/widgets/inputs/app_text_field.dart';
import 'package:starter_project/shared/widgets/pagination/app_pagination.dart';
import 'package:starter_project/shared/states/pagination_state.dart';

class AppDropdown<V> extends StatefulWidget {
  final SelectionController<V> controller;
  final List<SelectableItem<V, String>> items;
  final Widget Function(bool)? dropdownItemChild;
  final Widget Function(GlobalKey) target;
  final Function(List<String>)? onItemTap;
  final Future<PaginationState<SelectableItem<V, String>>> Function({
    String? value,
    bool forceRefresh,
  })?
  onLoad;

  final bool isMulti;
  final bool isSearchEnabled;

  const AppDropdown({
    super.key,
    required this.controller,
    required this.items,
    required this.target,
    required this.onItemTap,
    this.onLoad,
    this.dropdownItemChild,
    this.isMulti = false,
    this.isSearchEnabled = false,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final fieldController = TextEditingController();
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final layerLink = LayerLink();
  OverlayEntry? entry;
  final GlobalKey fieldKey = GlobalKey();
  late final ValueNotifier<PaginationState<SelectableItem>> state;

  @override
  void initState() {
    widget.onLoad?.call().then((value) => state..value = value);
    state = ValueNotifier(
      PaginationState(
        items: widget.items,
        isLoading: widget.onLoad != null ? true : false,
        isLastPage: widget.onLoad != null ? false : true,
        hasError: false,
        hasLoadMoreError: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CompositedTransformTarget(
          link: layerLink,
          child: GestureDetector(
            onTap: () {
              initDropDown();
              _showDropdown();
            },
            child: AbsorbPointer(child: widget.target(fieldKey)),
          ),
        ),
      ],
    );
  }

  void _removeDropdown() {
    entry?.remove();
    entry = null;
  }

  void _search(String value) async {
    if (widget.onLoad == null) {
      final filteredItems = widget.items
          .where((x) => x.data.contains(value))
          .toList();

      state.value = state.value.copyWith(items: filteredItems);
    } else {
      state.value = await widget.onLoad!(value: value, forceRefresh: true);
    }
  }

  void initDropDown() {
    // filteredItems.value
    //   ..clear()
    //   ..addAll(widget.items);

    // state.value = state.value.copyWith(items: widget.items);
    searchFocusNode.requestFocus();
  }

  void _showDropdown() {
    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeDropdown,
                behavior: HitTestBehavior.translucent,
              ),
            ),

            CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 60),
              child: Material(
                color: Colors.transparent,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  tween: Tween(begin: 0.95, end: 1),
                  builder: (context, scale, child) {
                    return Opacity(
                      opacity: scale,
                      child: Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: child,
                      ),
                    );
                  },
                  child: QuickContainer(
                    w:
                        (fieldKey.currentContext?.findRenderObject()
                                as RenderBox?)
                            ?.size
                            .width,
                    maxH: 260,

                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: context.colors.borderLight),
                    shadows: [
                      BoxShadow(
                        color: context.colors.onSurface.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.isSearchEnabled)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ).copyWith(bottom: 0),
                              child: AppTextField(
                                type: AppTextFieldType.search,
                                controller: searchController,
                                focusNode: searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: context.localizations.searchItem,
                                ),
                                onChanged: _search,
                              ),
                            ),
                          Flexible(
                            child: ValueListenableBuilder(
                              valueListenable: state,
                              builder: (context, paginationState, child) {
                                return ValueListenableBuilder(
                                  valueListenable: widget.controller,
                                  builder: (context, value, child) {
                                    return AppPagination(
                                      state: paginationState,
                                      onLoadMore: () async => widget.onLoad
                                          ?.call(value: searchController.text)
                                          .then((value) {
                                            state.value = value;
                                          }),

                                      onRefresh: () async => widget.onLoad
                                          ?.call(
                                            value: searchController.text,
                                            forceRefresh: true,
                                          )
                                          .then((value) {
                                            state.value = value;
                                          }),
                                      builder:
                                          (
                                            scrollController,
                                            itemBuilder,
                                            itemCount,
                                          ) {
                                            return ListView.builder(
                                              controller: scrollController,
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: itemCount,
                                              itemBuilder: itemBuilder,
                                            );
                                          },
                                      itemBuilder: (_, item, index) {
                                        final isSelected = widget.controller
                                            .isSelected(item.id);

                                        return InkWell(
                                          onTap: () {
                                            widget.controller.toggle(
                                              item.id,
                                              single: !widget.isMulti,
                                            );
                                            final labels = widget.items
                                                .where(
                                                  (item) => widget
                                                      .controller
                                                      .value
                                                      .contains(item.id),
                                                )
                                                .map((e) => e.data)
                                                .toList();
                                            widget.onItemTap?.call(labels);
                                            if (!widget.isMulti) {
                                              _removeDropdown();
                                            }
                                          },
                                          child:
                                              widget.dropdownItemChild?.call(
                                                isSelected,
                                              ) ??
                                              QuickContainer(
                                                px: AppSpacing.md,
                                                py: AppSpacing.sm,
                                                child: Row(
                                                  children: [
                                                    AnimatedSwitcher(
                                                      duration: const Duration(
                                                        milliseconds: 150,
                                                      ),
                                                      child:
                                                          isSelected &&
                                                              widget.isMulti
                                                          ? Icon(
                                                              Icons.check,
                                                              key: ValueKey(
                                                                true,
                                                              ),
                                                              size: 18,
                                                              color: context
                                                                  .colors
                                                                  .primary,
                                                            )
                                                          : const SizedBox.shrink(
                                                              key: ValueKey(
                                                                false,
                                                              ),
                                                            ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        item.data,
                                                        style: isSelected
                                                            ? context
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.semiBold()
                                                            : context
                                                                  .textTheme
                                                                  .bodyMedium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        );
                                      },
                                    );

                                    // return ListView.builder(
                                    //   physics: const BouncingScrollPhysics(),
                                    //   padding: const EdgeInsets.symmetric(
                                    //     vertical: 6,
                                    //   ),
                                    //   shrinkWrap: true,
                                    //   itemCount: filteredItemsList.length,

                                    //   },
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(entry!);
  }
}
