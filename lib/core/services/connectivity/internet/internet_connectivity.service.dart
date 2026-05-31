import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:async';

abstract interface class ConnectivityService {
  Future<bool> isConnected();
  Stream<bool> get onConnectionChanged;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  final InternetConnection _internetConnection;

  ConnectivityServiceImpl({
    Connectivity? connectivity,
    InternetConnection? internetConnection,
  }) : _connectivity = connectivity ?? Connectivity(),
       _internetConnection = internetConnection ?? InternetConnection();

  @override
  Future<bool> isConnected() async {
    return _internetConnection.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectionChanged {
    return _connectivity.onConnectivityChanged.asyncMap((_) async {
      return _internetConnection.hasInternetAccess;
    }).distinct();
  }
}
