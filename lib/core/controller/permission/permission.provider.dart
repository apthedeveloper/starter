import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/core/controller/permission/permission.controller.dart';
import 'package:starter_project/core/services/permission/permission.service.dart';
import 'package:starter_project/core/services/permission/permission.service_impl.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return const PermissionServiceImpl();
});

/// Provider for checking and subscribing to application permission statuses.
final permissionControllerProvider = Provider<PermissionController>(
  (ref) => PermissionController(ref.watch(permissionServiceProvider)),
);
