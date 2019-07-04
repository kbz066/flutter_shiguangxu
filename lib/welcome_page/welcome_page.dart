import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset("assets/images/bg_left_onestep.png"),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/bg_onestep.png",
            fit: BoxFit.contain,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset("assets/images/bg_right_onestep.png"),
        ),
        Align(
          alignment: Alignment(0, 0.9),
          child: Image.asset("assets/images/button_onestep.png"),
        ),
        Align(
          alignment: Alignment(-0.5, -0.39),
          child: Image.asset("assets/images/img_buy_onestep.png"),
        ),
        Align(
            alignment: Alignment(0.25, -0.12),
            child: Image.asset("assets/images/img_meet_onestep.png")),
        Align(alignment: Alignment(-0.3, 0.13), child: ImageMoveWidget()),
      ],
    );
  }
}

class ImageMoveWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ImageMoveWidgetState();
  }
}

class ImageMoveWidgetState extends State<ImageMoveWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<EdgeInsets> _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (BuildContext context, Widget child) {
        print("_animation       " + _animation.value.left.toString());
        return Container(

          transform: new Matrix4.translationValues(_animation.value.left, 0, 0),
          child: GestureDetector(
            child: Image.asset("assets/images/img_eat_onestep.png"),
            onTap: (){

            },
          ),
        );
      },
      animation: _animation,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = EdgeInsetsTween(
      begin: EdgeInsets.only(left: 350.0),
      end: EdgeInsets.only(left: 0.0),
    ).animate(_controller);
    _controller.forward();
  }
}
