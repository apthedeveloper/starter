import 'package:permission_handler/permission_handler.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';

class PermissionController {
  final PermissionService _permissionService;
  PermissionController(PermissionService permissionService)
    : _permissionService = permissionService;

  /// Checks the current permission status, updates state, and returns it.
  Future<PermissionStatus> checkStatus(
    PermissionType type, {
    PermissionGrant? grant,
  }) async {
    final status = await _permissionService.checkPermissionStatus(
      type,
      grant: grant,
    );
    return status;
  }

  /// Requests the permission, updates state, and returns the result.
  Future<PermissionStatus> request(
    PermissionType type, {
    PermissionGrant? grant,
  }) async {
    final status = await _permissionService.requestPermission(
      type,
      grant: grant,
    );
    return status;
  }
}
