
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/core/controller/internet_connectivity/internet_connectivity.controller.dart';
import 'package:starter_project/core/services/connectivity/internet/internet_connectivity.service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>(
  (ref) => ConnectivityServiceImpl(),
);

final connectivityControllerProvider =
    NotifierProvider<ConnectivityController, bool>(ConnectivityController.new);