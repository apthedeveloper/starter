import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:starter_project/core/logger/app_logger.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';

class PermissionServiceImpl implements PermissionService {
  const PermissionServiceImpl();

  /// Maps custom [PermissionType] and [PermissionGrant] to permission_handler's [ph.Permission].
  ph.Permission _mapToPermission(PermissionType type, PermissionGrant? grant) {
    switch (type) {
      case PermissionType.location:
        if (grant == PermissionGrant.always) {
          return ph.Permission.locationAlways;
        } else if (grant == PermissionGrant.whenInUse) {
          return ph.Permission.locationWhenInUse;
        }
        return ph.Permission.location;
      case PermissionType.camera:
        return ph.Permission.camera;
      case PermissionType.photos:
        return ph.Permission.photos;
      case PermissionType.microphone:
        return ph.Permission.microphone;
      case PermissionType.notification:
        return ph.Permission.notification;
      case PermissionType.contacts:
        return ph.Permission.contacts;
      case PermissionType.calendar:
        return ph.Permission.calendarFullAccess;
      case PermissionType.reminders:
        return ph.Permission.reminders;
      case PermissionType.bluetoothScan:
        return ph.Permission.bluetoothScan;
      case PermissionType.bluetoothConnect:
        return ph.Permission.bluetoothConnect;
      case PermissionType.bluetoothAdvertise:
        return ph.Permission.bluetoothAdvertise;
    }
  }

  @override
  Future<ph.PermissionStatus> checkPermissionStatus(
    PermissionType type, {
    PermissionGrant? grant,
  }) async {
    final permission = _mapToPermission(type, grant);
    return await permission.status;
  }

  @override
  Future<ph.PermissionStatus> requestPermission(
    PermissionType type, {
    PermissionGrant? grant,
  }) async {
    final permission = _mapToPermission(type, grant);
    return await permission.request();
  }

  @override
  Future<bool> isServiceEnabled(PermissionType type) async {
    switch (type) {
      case PermissionType.location:
        final status = await ph.Permission.location.serviceStatus;
        return status.isEnabled;
      case PermissionType.bluetoothScan:
      case PermissionType.bluetoothConnect:
      case PermissionType.bluetoothAdvertise:
        final status = await ph.Permission.bluetooth.serviceStatus;
        return status.isEnabled;
      default:
        return true;
    }
  }

  @override
  Future<bool> openAppSettings() async {
    return await ph.openAppSettings();
  }
}
