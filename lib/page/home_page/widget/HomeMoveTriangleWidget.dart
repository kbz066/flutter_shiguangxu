import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  HomeMoveTriangleWidget extends StatefulWidget {
  EdgeInsets begin;
  EdgeInsets end;



  HomeMoveTriangleWidget(this.begin,this.end);

  @override
  HomeMoveTriangleWidgetState createState() => new HomeMoveTriangleWidgetState(begin,end);
}

class HomeMoveTriangleWidgetState extends State<HomeMoveTriangleWidget> with SingleTickerProviderStateMixin {


  EdgeInsets begin;
  EdgeInsets end;
  Animation _animation;
  AnimationController _controller;



  HomeMoveTriangleWidgetState(this.begin,this.end);

  @override
  Widget build(BuildContext context) {
    return
     AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Container(


                  transform: Matrix4.translationValues(
                      _animation.value.left, 0, 0),
                  child: SizedBox(
                    width: _getWeekItemWidth(),
                    child: Image.asset(
                      "assets/images/home_bg.png",
                    ),
                  ));
            },
          );
  }
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation=EdgeInsetsTween(begin: this.begin, end: this.end).animate(_controller);


    print("打印  ${begin}  ${end}");
    _controller.forward();

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  double _getWeekItemWidth() {
    return window.physicalSize.width / window.devicePixelRatio / 7;
  }

}