import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_project/core/controller/permission/permission.provider.dart';
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';
import 'package:starter_project/shared/widgets/permission/permission_dialogs.dart';

/// Helper method to determine if a permission status can be considered a success.
bool _isPermissionSuccessful(PermissionStatus status) {
  return status == PermissionStatus.granted ||
      status == PermissionStatus.limited ||
      status == PermissionStatus.provisional;
}

/// Ensures that a specific permission is granted, handling all native hardware toggles,
/// explanations, prompts, and settings redirections in a single clean, async process.
///
/// Example:
/// ```dart
/// ensurePermission(
///   context,
///   type: PermissionType.location,
///   grantedType: PermissionGrant.always,
///   onPermissionGet: () => myMapController.loadUserLocation(),
/// );
/// ```
Future<void> ensurePermission(
  BuildContext context, {
  required PermissionType type,
  PermissionGrant? grantedType,
  required VoidCallback onPermissionGet,
  VoidCallback? onPermissionDenied,
  bool showRationale = true,
  String? rationaleTitle,
  String? rationaleMessage,
}) async {
  final container = ProviderScope.containerOf(context);
  final controller = container.read(permissionControllerProvider);
  final service = container.read(permissionServiceProvider);
  final shouldShowRationale =
      await Permission.camera.shouldShowRequestRationale;

  // 1. Check if the physical hardware service (e.g. GPS or Bluetooth) is enabled.
  final serviceOn = await service.isServiceEnabled(type);
  if (!context.mounted) return;

  if (!serviceOn) {
    final openedSettings = await PermissionDialogs.showServiceDisabledSheet(
      context: context,
      type: type,
    );

    if (!context.mounted) return;

    if (openedSettings) {
      await service.openAppSettings();
    }

    onPermissionDenied?.call();
    return;
  }

  var status = await controller.checkStatus(type, grant: grantedType);

  if (!context.mounted) return;

  // 3. If already granted, run success callback.
  if (_isPermissionSuccessful(status)) {
    onPermissionGet();
    return;
  }

  // 4. If denied (default/not determined), optionally show rationale sheet.
  if (status == PermissionStatus.denied &&
      showRationale &&
      shouldShowRationale) {
    final userApprovedRationale = await PermissionDialogs.showExplanationSheet(
      context: context,
      type: type,
      title: rationaleTitle,
      message: rationaleMessage,
    );

    if (!context.mounted) return;

    if (!userApprovedRationale) {
      onPermissionDenied?.call();
      return;
    }
  }
  status = await controller.request(type, grant: grantedType);

  if (!context.mounted) return;

  // 6. Final verification of requested permission status.
  if (_isPermissionSuccessful(status)) {
    onPermissionGet();
    return;
  }

  // 7. Permission is still unavailable after request.
  if (status == PermissionStatus.permanentlyDenied) {
    final openedSettings = await PermissionDialogs.showPermanentlyDeniedSheet(
      context: context,
      type: type,
    );

    if (!context.mounted) return;

    if (openedSettings) {
      await service.openAppSettings();
    }
  }

  onPermissionDenied?.call();
}
