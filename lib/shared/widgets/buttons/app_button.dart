import 'package:flutter/material.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';

enum ButtonType {
  primary,
  secondaryPrimary,
  secondaryOff,
  text,
  success,
  warning,
  info,
  danger,
}

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final ButtonType type;
  final ButtonSize size;

  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;

  final Widget? leading;
  final Widget? trailing;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? border;
  final TextStyle? textStyle;

  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.textStyle,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  Color _variantBackground(BuildContext context) {
    final colors = context.colors;

    switch (type) {
      case ButtonType.primary:
        return colors.primary;
      case ButtonType.secondaryPrimary:
        return colors.surface;
      case ButtonType.secondaryOff:
        return colors.surface;
      case ButtonType.success:
        return colors.success;
      case ButtonType.warning:
        return colors.warning;
      case ButtonType.info:
        return colors.info;
      case ButtonType.danger:
        return colors.error;
      case ButtonType.text:
        return Colors.transparent;
    }
  }

  Color _variantForeground(BuildContext context) {
    final colors = context.colors;

    switch (type) {
      case ButtonType.primary:
        return colors.onPrimary;
      case ButtonType.secondaryPrimary:
        return colors.primary;
      case ButtonType.secondaryOff:
        return colors.onSurfaceSecondary;
      case ButtonType.success:
        return colors.surface;
      case ButtonType.warning:
        return colors.surface;
      case ButtonType.info:
        return colors.surface;
      case ButtonType.danger:
        return colors.surface;
      case ButtonType.text:
        return colors.primary;
    }
  }

  BorderSide? _variantBorder(BuildContext context) {
    if (type == ButtonType.secondaryPrimary) {
      return BorderSide(color: context.colors.primary);
    }
    if (type == ButtonType.secondaryOff) {
      return BorderSide(color: context.colors.onSurfaceSecondary);
    }
    return null;
  }

  double _sizeHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  EdgeInsets _sizePadding() {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(horizontal: AppSpacing.sm);
      case ButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: AppSpacing.md);
      case ButtonSize.large:
        return EdgeInsets.symmetric(horizontal: AppSpacing.lg);
    }
  }

  double _height() => height ?? _sizeHeight();

  TextStyle _textStyle(BuildContext context) {
    final themeStyle = context.textTheme.labelLarge;

    return textStyle ??
        themeStyle?.copyWith(
          color: foregroundColor ?? _variantForeground(context),
        ) ??
        TextStyle(
          color: foregroundColor ?? _variantForeground(context),
          fontWeight: FontWeight.w600,
        );
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).elevatedButtonTheme.style;

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: _height(),
      child: ElevatedButton(
        onPressed: _isEnabled ? onPressed : null,

        style: themeStyle?.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? _variantBackground(context),
          ),
          foregroundColor: WidgetStatePropertyAll(
            foregroundColor ?? _variantForeground(context),
          ),
          padding: WidgetStatePropertyAll(padding ?? _sizePadding()),
          side: (border ?? _variantBorder(context)) != null
              ? WidgetStatePropertyAll(border ?? _variantBorder(context)!)
              : null,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
          ),
        ),

        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(
            foregroundColor ?? _variantForeground(context),
          ),
        ),
      );
    }

    final textWidget = Text(text, style: _textStyle(context));

    if (leading == null && trailing == null) return textWidget;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 8)],
        textWidget,
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );
  }
}
