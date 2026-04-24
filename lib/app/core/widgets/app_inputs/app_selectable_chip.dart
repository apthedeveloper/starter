import 'package:flutter/material.dart';
import 'package:starter_project/app/core/extensions/context.extenstion.dart';
import 'package:starter_project/app/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/core/widgets/app_selectable.dart';
import 'package:starter_project/app/core/controller/selection_controller.dart';
import 'package:starter_project/app/core/model/selection_item.dart';

class AppSelectableChip<V, D> extends StatelessWidget {
  final AppSelectionItem<V, String> item;
  final SelectionController<V> controller;
  final bool single;

  const AppSelectableChip({
    super.key,
    required this.item,
    required this.controller,
    this.single = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.isSelected(item.id);

    return AppSelectable(
      isSelected: isSelected,
      onTap: () => controller.toggle(item.id, single: single),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[Icon(item.icon, size: 16), 6.w],
          Text(item.data, style: context.textTheme.labelLarge),
        ],
      ),
    );
  }
}
