import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_type.dart';

class NetworkStatusManager {
  static final NetworkStatusManager instance = NetworkStatusManager._();

  factory NetworkStatusManager() => instance;

  NetworkStatusManager._();

  ///这是一个单例对象
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  ///当前网络状态
  NetworkType _networkType = NetworkType.none;

  NetworkType get networkType => _networkType;

  final StreamController<NetworkType> _streamController =
      StreamController.broadcast();

  ///网络状态变化的Stream
  Stream<NetworkType> get stream => _streamController.stream;

  void listenNetwork() async {
    try {
      ConnectivityResult result = await _connectivity.checkConnectivity();
      _networkType = _mapToNetworkType(result);
    } catch (_) {}
    _subscription =
        _connectivity.onConnectivityChanged.listen(_networkStatusChanged);
  }

  void cancel() {
    _subscription?.cancel();
  }

  void _networkStatusChanged(ConnectivityResult result) {
    final type = _mapToNetworkType(result);
    if (_networkType == type) return;
    _networkType = type;
    _streamController.add(type);
  }

  NetworkType _mapToNetworkType(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return NetworkType.bluetooth;
      case ConnectivityResult.wifi:
        return NetworkType.wifi;
      case ConnectivityResult.ethernet:
        return NetworkType.ethernet;
      case ConnectivityResult.mobile:
        return NetworkType.mobile;
      case ConnectivityResult.none:
        return NetworkType.none;
      case ConnectivityResult.vpn:
        return NetworkType.vpn;
      case ConnectivityResult.other:
        return NetworkType.other;
    }
  }
}
