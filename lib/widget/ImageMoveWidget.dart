import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_shiguangxu/common/WindowUtils.dart';

class ImageMoveWidget extends StatefulWidget {
  var time;

  var begin;
  var path;

  ImageMoveWidget(this.time,this.begin, this.path);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageMoveWidgetState(time, path);
  }
}

class ImageMoveWidgetState extends State<ImageMoveWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<EdgeInsets> _animation;


  var time;

  var path;

  ImageMoveWidgetState(this.time, this.path);

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        return Container(

          transform:   Matrix4.translationValues(_animation.value.left, 0, 0),
          child: Image.asset(path),
        );
      },
      animation: _animation,
    );
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds:widget.time));
    _animation = EdgeInsetsTween(
      begin: EdgeInsets.only(left: WindowUtils.getWidth()),
      end: EdgeInsets.only(left: 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        widget.begin,
        1,
        curve: Curves.linear,
      ),
    ));
    _controller.forward();
    super.initState();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
}