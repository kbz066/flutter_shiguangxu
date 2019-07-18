import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DemoHeader.dart';

class Test extends StatelessWidget {
  final List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.pink];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: CustomScrollView(


          physics: RefreshScrollPhysics(),
            slivers: <Widget>[
          SliverPersistentHeader(delegate: DemoHeader(), pinned: false,floating: false,),

          // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
          // 可以在 child 属性加入需要展示的部件
         NotificationListener(
           onNotification: (notification){
             print(notification);
             switch (notification.runtimeType){
               case ScrollStartNotification: print("开始滚动"); break;
               case ScrollUpdateNotification: print("正在滚动"); break;
               case ScrollEndNotification: print("滚动停止"); break;
               case OverscrollNotification: print("滚动到边界"); break;
             }
             return true;
           },
           child:  SliverList(


             delegate: new SliverChildBuilderDelegate(
                     (BuildContext context, int index) {
                   return Text("$index");
                 },
                 childCount: 200
             ),
           ),
         )
        ]
        )
    );
  }
}


class RefreshScrollPhysics extends ScrollPhysics{
  const RefreshScrollPhysics({ ScrollPhysics parent }) : super(parent: parent);
  @override
  RefreshScrollPhysics applyTo(ScrollPhysics ancestor) {
    return new RefreshScrollPhysics(parent: buildParent(ancestor));
  }
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // TODO: implement applyPhysicsToUserOffset

    print("applyPhysicsToUserOffset                   ${offset}");
    if(offset<0){
      return 100;
    }
    return offset;
  }
  //此处返回null时为了取消惯性滑动
//  @override
//  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
//
//
//    return  null;
//  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    print("velocity    ${position}     ${velocity}");
//    if (position.pixels<120) {
//
//
//      return ScrollSpringSimulation(
//        spring,
//        position.pixels,
//        120,
//        min(0.0, velocity),
//        tolerance: tolerance,
//      );
//    }
    if (velocity.abs() < tolerance.velocity)
      return null;
    if (velocity > 0.0 && position.pixels >= position.maxScrollExtent)
      return null;
    if (velocity < 0.0 && position.pixels <= position.minScrollExtent)
      return null;
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
    );
  }


}

