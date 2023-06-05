import 'dart:ui' as ui;
import 'package:flutter/material.dart';

abstract class ScreenInfoUtils {
  ///屏幕尺寸
  static Size get screenSize => MediaQueryData.fromWindow(ui.window).size;

  ///屏幕宽度
  static double get width => screenSize.width;

  ///屏幕高度
  static double get height => screenSize.height;

  ///屏幕Scale
  static double get scale =>
      MediaQueryData.fromWindow(ui.window).devicePixelRatio;

  ///屏幕textScaleFactor
  static double get textScale =>
      MediaQueryData.fromWindow(ui.window).textScaleFactor;

  ///AppBar的高度
  static double get appBarHeight => kToolbarHeight;

  ///BottomNavigationBar的高度
  static double get bottomNavHeight => kBottomNavigationBarHeight;

  ///AppBar的高度加上安全区域的高度
  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  ///头部安全区域的高度
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  ///底部安全区域的高度
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }
}