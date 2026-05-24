import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:starter_project/app/layout/app_layout.dart';
import 'package:starter_project/app/theme/colors/color_accessor.dart';
import 'package:starter_project/core/constants/app_durations.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/core/extensions/textstyle_extenstion.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/shared/widgets/inputs/app_media_picker.dart';

enum AppSheetHeaderAction { none, close, back }

final class AppSheet {
  AppSheet._();

  static Future<XFile?> showMediaPicker({
    required BuildContext context,
    bool isVideo = false,
  }) {
    return AppSheet.show<XFile?>(
      title: isVideo ? "Select a video" : "Select an image",
      subtitle: isVideo
          ? "Choose from your video library or take a video"
          : "Choose from your gallery or take a photo",
      action: AppSheetHeaderAction.back,
      context: context,
      child: AppMediaPickerSheet(isVideo: isVideo),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    AppSheetHeaderAction action = AppSheetHeaderAction.none,
    bool showHandle = true,
    bool showHeader = true,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool useSafeArea = true,
    double borderRadius = 28,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? barrierColor,
    Widget? bottom,
    double? maxHeight,
    VoidCallback? onActionTap,
  }) {
    final theme = context.colors;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor ?? theme.onSurface.withValues(alpha: 0.25),

      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);

        return AnimatedPadding(
          duration: AppDurations.fast,
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight ?? mediaQuery.size.height * 0.92,
              ),
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(2 * AppSpacing.md),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showHandle) ...[
                    12.h,
                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.onSurface,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],

                  if (showHeader)
                    _SheetHeader(
                      title: title,
                      subtitle: subtitle,
                      leadingAction: action,
                      onLeadingPressed: onActionTap,
                    ),

                  Flexible(
                    child: SingleChildScrollView(
                      padding:
                          padding ?? EdgeInsets.only(bottom: AppSpacing.xl),
                      child: child,
                    ),
                  ),

                  ?bottom,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

final class _SheetHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final AppSheetHeaderAction leadingAction;
  final VoidCallback? onLeadingPressed;

  const _SheetHeader({
    required this.title,
    required this.subtitle,
    required this.leadingAction,
    required this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasAction = leadingAction != AppSheetHeaderAction.none;

    return Padding(
      padding: AppLayout.screenPadding(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasAction && leadingAction == AppSheetHeaderAction.back)
            _button(
              icon: Icons.arrow_back_ios_new_rounded,
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
              theme: context.colors,
            )
          else
            42.w,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title != null)
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineSmall,
                  ),

                if (subtitle != null) ...[
                  2.h,
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.colour(
                      context.colors.onSurfaceSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (hasAction && leadingAction == AppSheetHeaderAction.close)
            _button(
              icon: Icons.close,
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
              theme: context.colors,
            )
          else
            42.w,
        ],
      ),
    );
  }

  Widget _button({
    required IconData icon,
    required VoidCallback onPressed,
    required AppThemeAccessor theme,
  }) {
    return AppButton(
      icon: icon,
      onPressed: onPressed,
      padding: 0.ap,
      width: 42,
      height: 42,
      elevation: 0,
      backgroundColor: theme.borderLight.withValues(alpha: 0.5),
      foregroundColor: theme.onSurface,
      borderRadius: BorderRadius.circular(100),
      fullWidth: false,
    );
  }
}
