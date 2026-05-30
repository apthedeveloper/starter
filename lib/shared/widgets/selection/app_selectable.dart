import 'package:flutter/material.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';

class AppSelectable extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  final bool nativeChangesDisabled;

  const AppSelectable({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.child,
    this.nativeChangesDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: QuickContainer(
        animated: true,
        duration: const Duration(milliseconds: 150),
          py: AppSpacing.sm,
          px: AppSpacing.md,
          color: nativeChangesDisabled || !isSelected
              ? colors.surface
              : colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(
            color: nativeChangesDisabled || !isSelected
                ? colors.borderLight
                : colors.primary,
          ),
        child: child,
      ),
    );
  }
}
