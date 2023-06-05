import '../storage/sp_utils.dart';
import 'device_utils.dart';
import 'package_utils.dart';

class UtilsInit {
  UtilsInit._();

  static Future init() async {
    await DeviceUtils.initDeviceInfo();
    await PackageUtils.initPackageInfo();
    await SPUtils.initSP();
  }
}
