import 'package:flutter/material.dart';
import 'package:starter_project/app/core/extensions/context.extenstion.dart';
import 'package:starter_project/app/core/services/feedback_services.dart';

enum SnackbarType { success, error, warning, info }

class SnackbarStyle {
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  const SnackbarStyle({
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  });
}

class SnackbarStyles {
  static SnackbarStyle getStyle(SnackbarType type, BuildContext context) {
    final colors = context.colors;
    switch (type) {
      case SnackbarType.success:
        return SnackbarStyle(
          backgroundColor: colors.success,
          iconColor: colors.successLight,
          icon: Icons.check_circle,
        );

      case SnackbarType.error:
        return SnackbarStyle(
          backgroundColor: colors.error,
          iconColor: colors.errorLight,
          icon: Icons.error,
        );

      case SnackbarType.warning:
        return SnackbarStyle(
          backgroundColor: colors.warning,
          iconColor: colors.warningLight,
          icon: Icons.warning,
        );

      case SnackbarType.info:
        return SnackbarStyle(
          backgroundColor: colors.primary,
          iconColor: colors.infoLight,
          icon: Icons.info,
        );
    }
  }
}

class AppSnackbar {
  static void show({
    required String message,
    SnackbarType type = SnackbarType.info,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = SnackBarTheme.of(
      FeedbackService.messengerKey.currentContext!,
    );
    final style = SnackbarStyles.getStyle(
      type,
      FeedbackService.messengerKey.currentContext!,
    );

    final snackBar = SnackBar(
      elevation: theme.elevation ?? 0,
      behavior: theme.behavior ?? SnackBarBehavior.floating,
      shape: theme.shape,
      margin: theme.insetPadding,
      duration: duration,

      /// Important: keep transparent so custom UI shows
      backgroundColor: Colors.transparent,

      content: _AppSnackbarContent(
        message: message,
        style: style,
        actionLabel: actionLabel,
        onAction: onAction,
        textStyle: theme.contentTextStyle,
      ),
    );

    FeedbackService.showSnackbar(snackBar);
  }
}

class _AppSnackbarContent extends StatelessWidget {
  final String message;
  final SnackbarStyle style;
  final String? actionLabel;
  final VoidCallback? onAction;
  final TextStyle? textStyle;
  const _AppSnackbarContent({
    required this.message,
    required this.style,
    this.actionLabel,
    this.onAction,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: style.backgroundColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.backgroundDark.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(style.icon, color: style.iconColor, size: 22),
          const SizedBox(width: 12),

          /// Message
          Expanded(
            child: Text(
              message,
              style:
                  textStyle?.copyWith(
                    color: textStyle?.color ?? colors.surface,
                    fontWeight: FontWeight.w500,
                  ) ??
                  TextStyle(
                    color: colors.surface,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),

          if (actionLabel != null) ...[
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style:
                    textStyle?.copyWith(
                      color: textStyle?.color ?? colors.surface,
                      fontWeight: FontWeight.w500,
                    ) ??
                    TextStyle(
                      color: colors.surface,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
