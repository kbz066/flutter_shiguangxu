import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DemoHeader.dart';

class Test extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    var list = List.generate(200, (int index) {
      return Text("$index");
    });
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          //print(notification);


          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              ScrollUpdateNotification scrollUpdateNotification=notification;

              print("正在滚动");
              break;
            case ScrollEndNotification:
              ScrollEndNotification endNotification =notification;
              //下滑到最底部
              if (notification.metrics.extentAfter == 0.0) {
               // print('======下滑到最底部======');

              }
              //滑动到最顶部
              if (notification.metrics.extentBefore == 0.0) {
               // print('======滑动到最顶部======');

              }
              print("滚动停止  ${ endNotification.metrics }");
              break;
            case OverscrollNotification:
              OverscrollNotification overscrollNotification=notification;

              print("滚动到边界  ${overscrollNotification.velocity}");
              break;


          }
          return true;
        },
        child: ListView(
          children: list,
        ),
      ),
    );
  }
}
