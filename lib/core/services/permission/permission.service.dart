import 'package:permission_handler/permission_handler.dart';

/// Supported permission types in the application.
enum PermissionType {
  location,
  camera,
  photos,
  microphone,
  notification,
  contacts,
  calendar,
  reminders,
  bluetoothScan,
  bluetoothConnect,
  bluetoothAdvertise,
  
}

/// Level of location permission required.
enum PermissionGrant {
  always,
  whenInUse,
}

/// Abstract contract defining the core permission management features.
abstract interface class PermissionService {
  /// Checks the current status of the given [PermissionType].
  Future<PermissionStatus> checkPermissionStatus(
    PermissionType type, {
    PermissionGrant? grant,
  });

  /// Requests the given [PermissionType] and returns the resulting status.
  Future<PermissionStatus> requestPermission(
    PermissionType type, {
    PermissionGrant? grant,
  });

  /// Checks if the native system service for a permission is enabled (e.g. Location or Bluetooth).
  Future<bool> isServiceEnabled(PermissionType type);

  /// Opens the app's settings screen in the native system settings.
  Future<bool> openAppSettings();
}
