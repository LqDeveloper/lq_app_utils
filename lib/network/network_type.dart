import 'dart:io';

enum NetworkType {
  /// 连接上蓝牙
  bluetooth,

  /// 连接上Wifi
  wifi,

  /// 连接到以太网网络的设备
  ethernet,

  /// 连接到蜂窝网络的设备
  mobile,

  /// 备未连接到任何网络
  none,

  /// 连接到 VPN 的设备
  ///
  /// iOS 和 macOS 注意事项：
  /// [vpn] 没有单独的网络接口类型。
  /// 它在任何设备（包括模拟器）上返回 [other]。
  vpn,

  /// 设备连接到未知网络
  other;

  ///是否连接网络
  bool get isConnected {
    if (Platform.isIOS || Platform.isMacOS) {
      return (this == NetworkType.wifi) ||
          (this == NetworkType.ethernet) ||
          (this == NetworkType.mobile) ||
          (this == NetworkType.other);
    } else {
      return (this == NetworkType.wifi) ||
          (this == NetworkType.ethernet) ||
          (this == NetworkType.mobile);
    }
  }

  ///当前没有网络连接
  bool get isNone => this == NetworkType.none;

  ///是否连接的是 Wifi
  bool get isWifi => this == NetworkType.wifi;

  ///是否连接的是蜂窝网络
  bool get isMobile => this == NetworkType.mobile;
}
