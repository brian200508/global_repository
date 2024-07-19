// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ScreenQuery extends InheritedWidget {
  ScreenQuery({
    required this.uiWidth,
    required Widget child,
    required this.screenWidth,
  }) : super(child: child) {
    if (screenWidth > 1000) {
      // 长边的dp大于1000，适配平板，就不能在对组件进行比例缩放
      // 小米10的长边是800多一点
      scale = 1.0;
    } else {
      scale = screenWidth / uiWidth;
    }
  }

  final double uiWidth;
  final double screenWidth;
  double scale = 1.0;

  @override
  bool updateShouldNotify(covariant ScreenQuery oldWidget) {
    return oldWidget.scale != scale;
  }

  double setWidth(num width) {
    return width * scale;
  }

  static ScreenQuery of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenQuery>()!;
  }
}

extension ScreenStateExt on State {
  double l(num width) {
    return ScreenQuery.of(context).setWidth(width);
  }
}

extension ScreenContextExt on BuildContext {
  double l(num width) {
    return ScreenQuery.of(this).setWidth(width);
  }
}
