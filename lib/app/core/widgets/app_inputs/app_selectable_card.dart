import 'package:flutter/material.dart';
import 'package:starter_project/app/core/extensions/context.extenstion.dart';
import 'package:starter_project/app/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/app/core/widgets/app_selectable.dart';
import 'package:starter_project/app/core/controller/selection_controller.dart';
import 'package:starter_project/app/core/model/selection_item.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';

class AppSelectableCard<V> extends StatelessWidget {
  final AppSelectionItem<V, String> item;
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 20,
            height: 20,
            padding: isSelected ? EdgeInsets.all(3) : EdgeInsets.zero,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? colors.primary : colors.borderLight,
              ),
              color: AppColors.white,
            ),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? colors.primary : Colors.transparent,
              ),
            ),
          ),
          12.w,
          Expanded(child: Text(item.data, style: context.textTheme.labelLarge)),
        ],
      ),
    );
  }
}
