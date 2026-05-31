import 'package:flutter/material.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/app/theme/colors/app_colors.dart';

enum PopupAction { confirm, cancel, dismiss }

class PopupResult<T> {
  final PopupAction action;
  final T? data;

  const PopupResult({required this.action, this.data});
}

enum PopupVariant { info, success, warning, danger, custom }

class AppPopup {
  static void _close(PopupResult result, BuildContext context) {
    Navigator.of(context).pop(result);
  }

  static Future<PopupResult?> show({
    required BuildContext context,
    required String title,
    String? message,
    IconData? icon,
    Widget? customIcon,
    Widget? extraContent,
    PopupVariant variant = PopupVariant.info,
    Color? accentColor,
    List<AppButton>? buttons,
    bool showCloseButton = true,
    bool barrierDismissible = true,
    bool blurBackground = true,
  }) {
    final colors = context.colors;

    return showGeneralDialog<PopupResult>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Popup',
      barrierColor: colors.backgroundDark.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => _AppPopupWidget(
        title: title,
        message: message,
        icon: icon,
        customIcon: customIcon,
        extraContent: extraContent,
        variant: variant,
        accentColor: accentColor,
        buttons:
            buttons ??
            [
              AppButton(
                text: context.localizations.cancel,
                type: ButtonType.secondaryOff,
                onPressed: () {
                  _close(PopupResult(action: PopupAction.cancel), context);
                },
              ),
              AppButton(
                text: context.localizations.confirm,
                type: ButtonType.primary,
                onPressed: () {
                  _close(PopupResult(action: PopupAction.confirm), context);
                },
              ),
            ],
        showCloseButton: showCloseButton,
        blurBackground: blurBackground,
      ),
      transitionBuilder: (_, anim, _, child) {
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
            child: child,
          ),
        );
      },
    );
  }

  // ── Predefined: Exit Confirmation ───────────────────────────────────────────
  static Future<PopupResult?> showExitConfirmation(BuildContext context) {
    return show(
      context: context,
      title: context.localizations.exitApp,
      message: context
          .localizations
          .areYouSureYouWantToLeaveAnyUnsavedChangesWillBeLost,
      icon: Icons.logout_rounded,
      variant: PopupVariant.danger,
      buttons: [
        AppButton(
          text: context.localizations.cancel,
          type: ButtonType.secondaryOff,
          onPressed: () {
            _close(PopupResult(action: PopupAction.cancel), context);
          },
        ),
        AppButton(
          text: context.localizations.exit,
          type: ButtonType.danger,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
        ),
      ],
    );
  }

  // ── Predefined: Delete Confirmation ─────────────────────────────────────────
  static Future<PopupResult?> showDeleteConfirmation(
    BuildContext context, {
    String? deleteItemName,
  }) {
    return show(
      context: context,
      title: 'Delete ${deleteItemName ?? context.localizations.thisItem}',
      message:
          context.localizations.thisActionCannotBeUndoneAreYouAbsolutelySure,
      icon: Icons.delete_outline_rounded,
      variant: PopupVariant.danger,
      buttons: [
        AppButton(
          text: context.localizations.keep,
          type: ButtonType.secondaryOff,
          onPressed: () {
            _close(PopupResult(action: PopupAction.cancel), context);
          },
        ),
        AppButton(
          text: context.localizations.delete,
          type: ButtonType.danger,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
          leading: Icon(Icons.delete, size: 18),
        ),
      ],
    );
  }

  // ── Predefined: Success ──────────────────────────────────────────────────────
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    String? buttonLabel,
  }) async {
    await show(
      context: context,
      title: title,
      message: message,
      icon: Icons.check_circle_outline_rounded,
      variant: PopupVariant.success,
      showCloseButton: false,
      buttons: [
        AppButton(
          text: buttonLabel ?? context.localizations.great,
          type: ButtonType.success,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
        ),
      ],
    );
  }

  // ── Predefined: Warning ──────────────────────────────────────────────────────
  static Future<PopupResult?> showWarning(
    BuildContext context, {
    required String title,
    String? message,
    String? confirmLabel,
    String? cancelLabel,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: Icons.warning_amber_rounded,
      variant: PopupVariant.warning,
      buttons: [
        AppButton(
          text: cancelLabel ?? context.localizations.goBack,
          type: ButtonType.secondaryOff,
          onPressed: () {
            _close(PopupResult(action: PopupAction.cancel), context);
          },
        ),
        AppButton(
          text: confirmLabel ?? context.localizations.proceed,
          type: ButtonType.warning,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
        ),
      ],
    );
  }

  // ── Predefined: Info ─────────────────────────────────────────────────────────
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    String? message,
    String? buttonLabel,
  }) async {
    await show(
      context: context,
      title: title,
      message: message,
      icon: Icons.info_outline_rounded,
      variant: PopupVariant.info,
      showCloseButton: false,
      buttons: [
        AppButton(
          text: buttonLabel ?? context.localizations.gotIt,
          type: ButtonType.info,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
        ),
      ],
    );
  }

  // ── Predefined: Logout ───────────────────────────────────────────────────────
  static Future<PopupResult?> showLogoutConfirmation(BuildContext context) {
    return show(
      context: context,
      title: context.localizations.logOut,
      message: context.localizations.youWillBeSignedOutOfYourAccount,
      icon: Icons.person_off_outlined,
      variant: PopupVariant.danger,
      buttons: [
        AppButton(
          text: context.localizations.cancel,
          type: ButtonType.secondaryOff,
          onPressed: () {
            _close(PopupResult(action: PopupAction.cancel), context);
          },
        ),
        AppButton(
          text: context.localizations.logOut,
          type: ButtonType.danger,
          onPressed: () {
            _close(PopupResult(action: PopupAction.confirm), context);
          },
        ),
      ],
    );
  }

  // ── Predefined: Custom Content ────────────────────────────────────────────────
  static Future<PopupResult?> showCustom({
    required BuildContext context,
    required String title,
    required Widget content,
    String? message,
    IconData? icon,
    Widget? customIcon,
    Color? accentColor,
    List<AppButton>? buttons,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      icon: icon,
      customIcon: customIcon,
      extraContent: content,
      variant: PopupVariant.custom,
      accentColor: accentColor,
      buttons: buttons,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INTERNAL POPUP WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _AppPopupWidget extends StatefulWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final Widget? customIcon;
  final Widget? extraContent;
  final PopupVariant variant;
  final Color? accentColor;
  final List<AppButton> buttons;
  final bool showCloseButton;
  final bool blurBackground;

  const _AppPopupWidget({
    required this.title,
    this.message,
    this.icon,
    this.customIcon,
    this.extraContent,
    required this.variant,
    this.accentColor,
    required this.buttons,
    required this.showCloseButton,
    required this.blurBackground,
  });

  @override
  State<_AppPopupWidget> createState() => _AppPopupWidgetState();
}

class _AppPopupWidgetState extends State<_AppPopupWidget>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // ── Variant colors ───────────────────────────────────────────────────────────
  Color get _accentColor {
    if (widget.accentColor != null) return widget.accentColor!;
    final colors = context.colors;
    switch (widget.variant) {
      case PopupVariant.success:
        return colors.success;
      case PopupVariant.warning:
        return colors.warning;
      case PopupVariant.danger:
        return colors.error;
      case PopupVariant.info:
        return colors.info;
      case PopupVariant.custom:
        return colors.secondary;
    }
  }

  void _close(PopupResult result) {
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Center(
      child: Material(
        color: AppColors.transparent,
        child: QuickContainer(
          w: size.width * 0.88,
          maxW: 420,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Card ────────────────────────────────────────────────────────
              _buildCard(isDark, context),

              // ── Icon bubble (floats above card) ─────────────────────────────
              if (widget.icon != null || widget.customIcon != null)
                Positioned(
                  top: -36,
                  left: 0,
                  right: 0,
                  child: _buildIconBubble(),
                ),

              // ── Close button ─────────────────────────────────────────────────
              if (widget.showCloseButton)
                Positioned(
                  top: 12,
                  right: 12,
                  child: _buildCloseButton(isDark),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Card body ────────────────────────────────────────────────────────────────
  Widget _buildCard(bool isDark, BuildContext context) {
    final hasIcon = widget.icon != null || widget.customIcon != null;
    return QuickContainer(
      borderRadius: BorderRadius.circular(28),
      color: isDark ? context.colors.backgroundDark : context.colors.surface,
      shadows: [
        BoxShadow(
          color: _accentColor.withValues(alpha: 0.18),
          blurRadius: 40,
          spreadRadius: -4,
          offset: const Offset(0, 20),
        ),
        BoxShadow(
          color: context.colors.backgroundLight.withValues(alpha: 0.12),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(
        color: _accentColor.withValues(alpha: 0.15),
        width: 1.5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Gradient top strip
            _buildTopStrip(),
            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(24, hasIcon ? 44 : 24, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (hasIcon) const SizedBox(height: 8),
                  // Title
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (widget.message != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      widget.message!,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? context.colors.borderDark
                            : context.colors.onSurfaceSecondary,
                      ),
                    ),
                  ],
                  if (widget.extraContent != null) ...[
                    const SizedBox(height: 16),
                    widget.extraContent!,
                  ],
                  const SizedBox(height: 28),
                  _buildButtons(isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Thin animated gradient strip at top ─────────────────────────────────────
  Widget _buildTopStrip() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (_, _) {
        final value = Curves.easeInOut.transform(_shimmerController.value);

        return QuickContainer(
          h: 4,
          borderRadius: BorderRadius.circular(2),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              _accentColor.withValues(alpha: 0.15),
              _accentColor.withValues(alpha: 0.6),
              _accentColor,
              _accentColor.withValues(alpha: 0.6),
              _accentColor.withValues(alpha: 0.15),
            ],
            stops: [
              (value - 0.4).clamp(0.0, 1.0),
              (value - 0.2).clamp(0.0, 1.0),
              value.clamp(0.0, 1.0),
              (value + 0.2).clamp(0.0, 1.0),
              (value + 0.4).clamp(0.0, 1.0),
            ],
          ),
        );
      },
    );
  }

  // ── Floating icon bubble ─────────────────────────────────────────────────────
  Widget _buildIconBubble() {
    return Center(
      child: QuickContainer(
        w: 72,
        h: 72,
        shape: .circle,
        color: _accentColor,
        shadows: [
          BoxShadow(
            color: _accentColor.withValues(alpha: 0.45),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        child:
            widget.customIcon ??
            Icon(widget.icon, color: context.colors.onPrimary, size: 34),
      ),
    );
  }

  // ── Close button ──────────────────────────────────────────────────────────────
  Widget _buildCloseButton(bool isDark) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => _close(PopupResult(action: .dismiss)),
      child: QuickContainer(
        w: 32,
        h: 32,
        shape: .circle,
        color: isDark
            ? colors.onPrimary.withValues(alpha: 0.08)
            : colors.backgroundDark.withValues(alpha: 0.06),

        child: Icon(
          Icons.close_rounded,
          size: 17,
          color: isDark ? colors.onSurfaceSecondary : colors.onSurface,
        ),
      ),
    );
  }

  // ── Buttons row ───────────────────────────────────────────────────────────────
  Widget _buildButtons(bool isDark) {
    if (widget.buttons.isEmpty) return const SizedBox.shrink();

    if (widget.buttons.length == 1) {
      return widget.buttons.first;
    }

    // Two buttons side-by-side
    if (widget.buttons.length == 2) {
      return Row(
        children: widget.buttons
            .map(
              (btn) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: btn == widget.buttons.first ? 0 : 6,
                    right: btn == widget.buttons.last ? 0 : 6,
                  ),
                  child: btn,
                ),
              ),
            )
            .toList(),
      );
    }

    // 3+ buttons stacked
    return Column(
      children: widget.buttons
          .map(
            (btn) =>
                Padding(padding: const EdgeInsets.only(bottom: 10), child: btn),
          )
          .toList(),
    );
  }
}
