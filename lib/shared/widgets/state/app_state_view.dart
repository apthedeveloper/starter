import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';

enum AppViewType { empty, error }

class AppStateView extends StatelessWidget {
  final AppViewType type;

  final String? message;
  final String? subtitle;

  final IconData? icon;
  final String? lottieAsset;
  final double? lottieWidth;
  final bool repeat;

  final VoidCallback? onAction;
  final String? actionText;

  const AppStateView({
    super.key,
    this.type = AppViewType.empty,
    this.message,
    this.subtitle,
    this.icon,
    this.lottieAsset,
    this.lottieWidth,
    this.repeat = true,
    this.onAction,
    this.actionText,
  }) : assert(
         icon == null || lottieAsset == null,
         'Provide either icon or lottieAsset, not both.',
       );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final resolvedMessage =
        message ??
        (type == AppViewType.error ? context.localizations.somethingWentWrong : context.localizations.noDataFound);

    final resolvedSubtitle =
        subtitle ??
        (type == AppViewType.error
            ? context.localizations.pleaseTryAgain
            : context.localizations.tryRefreshingOrCheckBackLater);

    final resolvedActionText =
        actionText ?? (type == AppViewType.error ? context.localizations.retry : context.localizations.refresh);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (lottieAsset != null)
              SizedBox(
                width: lottieWidth ?? MediaQuery.sizeOf(context).width * 0.7,
                child: Lottie.asset(lottieAsset!, repeat: repeat),
              ),

            Icon(
              icon ??
                  (type == AppViewType.error
                      ? Icons.error_outline
                      : Icons.inbox_outlined),
              size: 72,
              color: type == AppViewType.error
                  ? colors.error
                  : colors.primary.withValues(alpha: 0.7),
            ),

            const SizedBox(height: 16),

            Text(
              resolvedMessage,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.onSurface.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              resolvedSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),

            if (onAction != null) ...[
              const SizedBox(height: 20),
              AppButton(onPressed: onAction, text: resolvedActionText),
            ],
          ],
        ),
      ),
    );
  }
}
