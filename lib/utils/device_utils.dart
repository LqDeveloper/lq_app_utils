import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

///设备信息
class DeviceUtils {
  DeviceUtils._();

  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static late BaseDeviceInfo _deviceInfo;

  ///使用之前必须初始化设备信息
  static Future<void> initDeviceInfo() async {
    if (Platform.isAndroid) {
      _deviceInfo = await _deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      _deviceInfo = await _deviceInfoPlugin.iosInfo;
    }
  }

  /// 将设备信息以Map的形式返回
  static Map<String, dynamic> get infoMap => _deviceInfo.data;

  ///当前设备是否是Android
  static bool get isAndroid => Platform.isAndroid;

  ///当前设备是否是iOS
  static bool get isIOS => Platform.isIOS;

  ///获取Android设备信息
  static AndroidDeviceInfo get androidInfo {
    return _deviceInfo as AndroidDeviceInfo;
  }

  ///获取iOS设备信息
  static IosDeviceInfo get iosInfo {
    return _deviceInfo as IosDeviceInfo;
  }
}
