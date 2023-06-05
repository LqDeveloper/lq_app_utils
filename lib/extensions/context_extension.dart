import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ///获取ThemeDa
  ThemeData get theme => Theme.of(this);

  ///获取屏幕尺寸
  Size get mediaQuerySize => MediaQuery.of(this).size;

  ///获取屏幕宽度
  double get width => mediaQuerySize.width;

  ///获取屏幕高度
  double get height => mediaQuerySize.height;

  ///获取屏幕的方向
  Orientation get orientation => MediaQuery.of(this).orientation;

  ///是否是横屏
  bool get isLandscape => orientation == Orientation.landscape;

  ///是否是竖屏
  bool get isPortrait => orientation == Orientation.portrait;

  ///获取RenderBox
  RenderBox? get renderBox {
    RenderObject? renderObject = findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      return renderObject;
    }
    return null;
  }

  ///获取Widget在屏幕中的位置
  Offset? get location {
    return renderBox?.localToGlobal(Offset.zero);
  }

  ///获取Widget的大小
  Size? get size {
    return renderBox?.paintBounds.size;
  }
}

extension CustomRouterExtension on BuildContext {
  ///当前页面路由的名字
  String? get routeName => ModalRoute.of(this)?.settings.name;

  ///获取传递的参数
  Object? get arguments => ModalRoute.of(this)?.settings.arguments;
}
