import 'dart:async';

import 'package:flutter/material.dart' hide Action;

class ImageMoveWidget extends StatefulWidget {
  var time;

  var path;

  ImageMoveWidget(this.time, this.path);

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
          transform: new Matrix4.translationValues(_animation.value.left, 0, 0),
          child: Image.asset(path),
        );
      },
      animation: _animation,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    _animation = EdgeInsetsTween(
      begin: EdgeInsets.only(left: mediaQuery.size.width),
      end: EdgeInsets.only(left: 0.0),
    ).animate(_controller);

    Timer(Duration(milliseconds: time), () {
      _controller.forward();
    });
    print("physicalSize-------------------------------->  " +
        "      " +
        mediaQuery.size.width.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}