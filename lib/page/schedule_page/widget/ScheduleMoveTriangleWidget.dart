import 'dart:ui';


import 'package:flutter/material.dart';

class ScheduleMoveTriangleWidget extends StatefulWidget {

  EdgeInsets moveEdgeInsets;

  ScheduleMoveTriangleWidget(this.moveEdgeInsets);

  @override
  ScheduleMoveTriangleWidgetState createState() => ScheduleMoveTriangleWidgetState();
}

class ScheduleMoveTriangleWidgetState extends State<ScheduleMoveTriangleWidget>
    with TickerProviderStateMixin {

  Animation _animation;
  AnimationController _controller;


  @override
  Widget build(BuildContext context) {


    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return Container(
            transform: Matrix4 .translationValues(_animation.value.left, 0, 0),
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
  void didUpdateWidget(ScheduleMoveTriangleWidget oldWidget) {

    // TODO: implement didUpdateWidget

    if(widget.moveEdgeInsets.left!=oldWidget.moveEdgeInsets.left){
      setState(() {
        startMoveAnimation(oldWidget);
      });
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void initState() {
    super.initState();

    startMoveAnimation(null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  double _getWeekItemWidth() {
    return window.physicalSize.width / window.devicePixelRatio / 7;
  }

  startMoveAnimation(ScheduleMoveTriangleWidget oldWidget){
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        EdgeInsetsTween(begin: oldWidget==null?widget.moveEdgeInsets:oldWidget.moveEdgeInsets, end: widget.moveEdgeInsets).animate(_controller);

//    print("打印  ${widget.begin}  ${widget.end}");
    _controller.forward();
  }
}