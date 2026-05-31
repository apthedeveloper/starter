import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_project/core/controller/internet_connectivity/internet_connectivity.provider.dart';
import 'package:starter_project/core/services/connectivity/internet/internet_connectivity.service.dart';

class ConnectivityController extends Notifier<bool> {
  late final ConnectivityService _service;
  StreamSubscription<bool>? _subscription;

  @override
  bool build() {
    _service = ref.read(connectivityServiceProvider);

    _subscription = _service.onConnectionChanged.listen((connected) {
      state = connected;
    });

    ref.onDispose(() => _subscription?.cancel());

    return true;
  }
}
