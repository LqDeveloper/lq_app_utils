import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef CopyCallBack = void Function(bool result);
typedef CopyDataCallBack = void Function(String? result);

/// 系统工具类
class SystemUtils {
  SystemUtils._();

  /// 隐藏软键盘，具体可看：TextInputChannel 并不取消焦点
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// 展示软键盘，具体可看：TextInputChannel
  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  ///隐藏键盘并取消焦点
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// 清除数据
  static void clearClientKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.clearClient');
  }

  /// 拷贝文本内容到剪切板
  static void copyToClipboardWithCallBack(String? text, CopyCallBack callBack) {
    if (text != null && text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text))
          .then((value) => callBack(true));
    } else {
      callBack(false);
    }
  }

  ///获取拷贝的数据
  static void getClipboardData(CopyDataCallBack callback) {
    Clipboard.getData(Clipboard.kTextPlain)
        .then((value) => callback(value?.text));
  }
}
