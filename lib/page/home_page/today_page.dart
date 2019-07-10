import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/HomeWeekCalendarWidget.dart';

class ToDayPage extends StatefulWidget {
  @override
  _ToDayPageState createState() => _ToDayPageState();
}

class _ToDayPageState extends State<ToDayPage>
    with SingleTickerProviderStateMixin {
  EdgeInsetsTween _tween;
  Animation<EdgeInsets> _animation;
  AnimationController _controller;
  double lastMoveIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _tween = new EdgeInsetsTween(
        begin: EdgeInsets.only(left: 0.0), end: EdgeInsets.only(left: 0.0));
    _animation = _tween.animate(_controller);

    _animation.addStatusListener((AnimationStatus status) {


    });
  }

  moveIndex(int index) {





  }

  @override
  Widget build(BuildContext context) {
    print("屏幕宽度  ${window.devicePixelRatio}");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.mainColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTopWidget(),
          HomeWeekCalendarWidget(this.moveIndex),
//          AnimatedBuilder(
//            animation: _animation,
//            builder: (BuildContext context, Widget child) {
//              return Container(
//                  padding: EdgeInsets.only(left: _animation.value.left),
//                  transform: Matrix4.translationValues(
//                      0, -_getWeekItemWidthDP() / 6, 0),
//                  child: SizedBox(
//                    width: _getWeekItemWidthDP(),
//                    child: Image.asset(
//                      "assets/images/home_bg.png",
//                    ),
//                  ));
//            },
//          ),
        ],
      ),
    );
  }
}

double _getWeekItemWidthDP() {
  return window.physicalSize.width / window.devicePixelRatio / 7;
}

_buildTopWidget() {
  return Container(
    color: ColorUtils.mainColor,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Image.asset(
                "assets/images/abc_ic_menu_copy_mtrl_am_alpha.png",
                color: Colors.white70,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    padding:
                        EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(40, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Text(
                      "改变自己,从现在做起",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Image.asset("assets/images/home_img_totoro.png")
          ],
        )
      ],
    ),
  );
}
