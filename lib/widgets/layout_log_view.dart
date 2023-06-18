import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LayoutLogView<T> extends StatelessWidget {
  const LayoutLogView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        if (kDebugMode) {
          log('当前组件的约束信息：$constraints', name: 'LayoutBuilder');
        }
        return true;
      }());
      return child;
    });
  }
}
