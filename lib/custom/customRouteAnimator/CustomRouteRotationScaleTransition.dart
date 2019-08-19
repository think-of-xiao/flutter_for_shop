import 'package:flutter/material.dart';

/// 旋转+缩放+背景色渐变路由动画过渡效果
class CustomRouteRotationScaleTransition extends PageRouteBuilder {
  final Widget widget;

  CustomRouteRotationScaleTransition(this.widget)
      : super(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation1,
                Animation<double> animation2) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1, curve: Curves.fastOutSlowIn)),
                  child: ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animation1, curve: Curves.fastOutSlowIn)),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation1, curve: Curves.easeInOutBack)),
                      child: child,
                    ),
                  ));
            });
}
