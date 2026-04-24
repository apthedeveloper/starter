import 'package:flutter/material.dart';
import 'package:starter_project/app/core/constants/app_spacing.dart';
import 'package:starter_project/app/core/extensions/context.extenstion.dart';

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: nativeChangesDisabled || !isSelected
              ? colors.surface
              : colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(
            color: nativeChangesDisabled || !isSelected
                ? colors.borderLight
                : colors.primary,
          ),
        ),
        child: child,
      ),
    );
  }
}
