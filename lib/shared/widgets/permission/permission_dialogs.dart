import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_container/quick_container.dart';
import 'package:starter_project/core/constants/app_spacing.dart';
import 'package:starter_project/core/extensions/context.extenstion.dart';
import 'package:starter_project/core/extensions/spacing.extenstion.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';
import 'package:starter_project/shared/widgets/buttons/app_button.dart';
import 'package:starter_project/shared/widgets/feedbacks/app_sheet.dart';

class PermissionDialogs {
  PermissionDialogs._();

  /// Gets the icon and primary color accent corresponding to the [PermissionType].
  static ({IconData icon, Color color, String name}) _getPermissionDetails(
    BuildContext context,
    PermissionType type,
  ) {
    final l10n = context.localizations;
    switch (type) {
      case PermissionType.location:
        return (
          icon: Icons.location_on_rounded,
          color: context.colors.primary,
          name: l10n.permissionLocationName,
        );
      case PermissionType.camera:
        return (
          icon: Icons.camera_alt_rounded,
          color: context.colors.secondary,
          name: l10n.permissionCameraName,
        );
      case PermissionType.photos:
        return (
          icon: Icons.photo_library_rounded,
          color: context.colors.success,
          name: l10n.permissionPhotosName,
        );
      case PermissionType.microphone:
        return (
          icon: Icons.mic_rounded,
          color: context.colors.warning,
          name: l10n.permissionMicrophoneName,
        );
      case PermissionType.notification:
        return (
          icon: Icons.notifications_active_rounded,
          color: context.colors.info,
          name: l10n.permissionNotificationName,
        );
      case PermissionType.bluetoothScan:
      case PermissionType.bluetoothConnect:
      case PermissionType.bluetoothAdvertise:
        return (
          icon: Icons.bluetooth_rounded,
          color: context.colors.primary,
          name: l10n.permissionBluetoothName,
        );
      case PermissionType.contacts:
        return (
          icon: Icons.contacts_rounded,
          color: context.colors.success,
          name: l10n.permissionContactsName,
        );
      case PermissionType.calendar:
        return (
          icon: Icons.calendar_today_rounded,
          color: context.colors.primary,
          name: l10n.permissionCalendarName,
        );
      case PermissionType.reminders:
        return (
          icon: Icons.alarm_rounded,
          color: context.colors.warning,
          name: l10n.permissionRemindersName,
        );
    }
  }

  /// Displays a premium explanation/rationale bottom sheet before requesting a permission.
  static Future<bool> showExplanationSheet({
    required BuildContext context,
    required PermissionType type,
    String? title,
    String? message,
    List<String>? bulletPoints,
  }) async {
    final details = _getPermissionDetails(context, type);
    final l10n = context.localizations;
    final displayTitle = title ?? l10n.enablePermissionAccess(details.name);
    final displayMessage =
        message ??
        l10n.defaultPermissionExplanation(details.name.toLowerCase());

    final displayBullets = bulletPoints ?? _getDefaultBullets(context, type);

    HapticFeedback.lightImpact();

    final result = await AppSheet.show<bool>(
      context: context,
      showHeader: false,
      showHandle: false,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: _PermissionSheetTemplate(
        icon: details.icon,
        accentColor: details.color,
        title: displayTitle,
        message: displayMessage,
        bulletPoints: displayBullets,
        primaryButtonText: l10n.grantPermission,
        secondaryButtonText: l10n.notNow,
      ),
    );

    return result ?? false;
  }

  /// Displays a beautiful modal when the native service is turned off (e.g. GPS or Bluetooth is off).
  static Future<bool> showServiceDisabledSheet({
    required BuildContext context,
    required PermissionType type,
  }) async {
    final isBluetooth = [
      PermissionType.bluetoothScan,
      PermissionType.bluetoothConnect,
      PermissionType.bluetoothAdvertise,
    ].contains(type);
    final l10n = context.localizations;
    final serviceName = isBluetooth
        ? l10n.bluetoothService
        : l10n.locationServices;

    HapticFeedback.mediumImpact();

    final result = await AppSheet.show<bool>(
      context: context,
      showHeader: false,
      showHandle: false,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: _PermissionSheetTemplate(
        icon: isBluetooth
            ? Icons.bluetooth_disabled_rounded
            : Icons.location_off_rounded,
        accentColor: context.colors.error,
        title: l10n.serviceIsOff(serviceName),
        message: l10n.serviceOffExplanation(serviceName),
        bulletPoints: [
          l10n.serviceDisabledBullet1,
          l10n.serviceDisabledBullet2,
          l10n.serviceDisabledBullet3,
        ],
        primaryButtonText: l10n.openSystemSettings,
        secondaryButtonText: l10n.goBackBtn,
      ),
    );

    return result ?? false;
  }

  /// Displays an instructions sheet redirecting to native settings when a permission is permanently denied.
  static Future<bool> showPermanentlyDeniedSheet({
    required BuildContext context,
    required PermissionType type,
  }) async {
    final details = _getPermissionDetails(context, type);
    final l10n = context.localizations;

    HapticFeedback.heavyImpact();

    final result = await AppSheet.show<bool>(
      context: context,
      showHeader: false,
      showHandle: false,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: _PermissionSheetTemplate(
        icon: details.icon,
        accentColor: context.colors.warning,
        title: l10n.permissionAccessDisabled(details.name),
        message: l10n.permissionDisabledExplanation(details.name),
        bulletPoints: [
          l10n.permanentlyDeniedBullet1,
          l10n.permanentlyDeniedBullet2(details.name),
          l10n.permanentlyDeniedBullet3,
        ],
        primaryButtonText: l10n.openAppSettings,
        secondaryButtonText: l10n.cancel,
      ),
    );

    return result ?? false;
  }

  /// Default rationale points for each permission type.
  static List<String> _getDefaultBullets(
    BuildContext context,
    PermissionType type,
  ) {
    final l10n = context.localizations;
    switch (type) {
      case PermissionType.location:
        return [
          l10n.bulletLocation1,
          l10n.bulletLocation2,
          l10n.bulletLocation3,
        ];
      case PermissionType.camera:
        return [l10n.bulletCamera1, l10n.bulletCamera2, l10n.bulletCamera3];
      case PermissionType.photos:
        return [l10n.bulletPhotos1, l10n.bulletPhotos2, l10n.bulletPhotos3];
      case PermissionType.microphone:
        return [
          l10n.bulletMicrophone1,
          l10n.bulletMicrophone2,
          l10n.bulletMicrophone3,
        ];
      case PermissionType.notification:
        return [
          l10n.bulletNotification1,
          l10n.bulletNotification2,
          l10n.bulletNotification3,
        ];
      case PermissionType.bluetoothScan:
      case PermissionType.bluetoothConnect:
      case PermissionType.bluetoothAdvertise:
        return [
          l10n.bulletBluetooth1,
          l10n.bulletBluetooth2,
          l10n.bulletBluetooth3,
        ];
      case PermissionType.contacts:
        return [
          l10n.bulletContacts1,
          l10n.bulletContacts2,
          l10n.bulletContacts3,
        ];
      case PermissionType.calendar:
        return [
          l10n.bulletCalendar1,
          l10n.bulletCalendar2,
          l10n.bulletCalendar3,
        ];
      case PermissionType.reminders:
        return [
          l10n.bulletReminders1,
          l10n.bulletReminders2,
          l10n.bulletReminders3,
        ];
    }
  }
}

/// The beautiful, standard template for rendering permission bottom sheets.
class _PermissionSheetTemplate extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final String title;
  final String message;
  final List<String> bulletPoints;
  final String primaryButtonText;
  final String secondaryButtonText;

  const _PermissionSheetTemplate({
    required this.icon,
    required this.accentColor,
    required this.title,
    required this.message,
    required this.bulletPoints,
    required this.primaryButtonText,
    required this.secondaryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSpacing.md.h,
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glowing background aura
              QuickContainer(
                w: 4 * AppSpacing.xl,
                h: 4 * AppSpacing.xl,
                radius: 100,
                color: accentColor.withValues(alpha: 0.08),
                child: const SizedBox.shrink(),
              ),
              // Outer ring
              QuickContainer(
                w: 3 * AppSpacing.xl,
                h: 3 * AppSpacing.xl,
                radius: 100,
                color: accentColor.withValues(alpha: 0.12),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.25),
                  width: 2,
                ),
                child: Icon(icon, size: 38, color: accentColor),
              ),
            ],
          ),
        ),
        AppSpacing.xl.h,

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: -0.3,
          ),
        ),
        AppSpacing.md.h,

        // Message
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colors.onSurfaceSecondary,
              height: 1.4,
            ),
          ),
        ),
        AppSpacing.xl.h,

        // Beautiful Bullet points list
        if (bulletPoints.isNotEmpty) ...[
          QuickContainer(
            px: AppSpacing.lg,
            py: AppSpacing.md,
            radius: AppSpacing.md,
            color: context.colors.backgroundDark.withValues(alpha: 0.5),
            border: Border.all(
              color: context.colors.onSurfaceSecondary,
              width: 1,
            ),
            child: Column(
              children: bulletPoints
                  .map(
                    (point) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpacing.xs + 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: accentColor,
                            ),
                          ),
                          AppSpacing.md.w,
                          Expanded(
                            child: Text(
                              point,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          (2 * AppSpacing.md).h,
        ],

        // CTA Action Buttons
        Row(
          children: [
            // Secondary/Cancel
            Expanded(
              child: AppButton(
                text: secondaryButtonText,
                type: ButtonType.secondaryOff,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.pop(context, false);
                },
              ),
            ),
            AppSpacing.md.w,

            // Primary Action
            Expanded(
              child: AppButton(
                text: primaryButtonText,
                type: ButtonType.primary,
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
