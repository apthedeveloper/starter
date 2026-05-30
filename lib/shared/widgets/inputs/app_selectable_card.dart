import 'package:flutter/material.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/shared/widgets/selection/app_selectable.dart';
import 'package:starter_project/shared/controllers/selection_controller.dart';
import 'package:starter_project/shared/models/selectable_item.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';

class AppSelectableCard<V> extends StatelessWidget {
  final SelectableItem<V, String> item;
  final SelectionController<V> controller;
  final bool single;

  const AppSelectableCard({
    super.key,
    required this.item,
    required this.controller,
    this.single = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.isSelected(item.id);
    final colors = context.colors;

    return AppSelectable(
      isSelected: isSelected,
      nativeChangesDisabled: true,
      onTap: () => controller.toggle(item.id, single: single),
      child: Row(
        children: [
     QuickContainer(
        animated: true,
            duration: const Duration(milliseconds: 150),
            w: 20,
            h: 20,
            p: isSelected ? 3: 0,
              shape: .circle,
              border: Border.all(
                color: isSelected ? colors.primary : colors.borderLight,
              ),
              color: AppColors.white,
            child: QuickContainer(
              w: double.infinity,
              h: double.infinity,
                shape: .circle,
                color: isSelected ? colors.primary : Colors.transparent,
            ),
          ),
          12.w,
          Expanded(child: Text(item.data, style: context.textTheme.labelLarge)),
        ],
      ),
    );
  }
}
