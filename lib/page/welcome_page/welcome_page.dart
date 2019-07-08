import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_shiguangxun/common/ImageMoveWidget.dart';
import 'package:flutter_shiguangxun/page/login_page/LoginPage.dart';

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
            child: InkWell(
              child: Image.asset("assets/images/button_onestep.png"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
            )),
        Align(
            alignment: Alignment(-0.5, -0.39),
            child: ImageMoveWidget(1000, "assets/images/img_buy_onestep.png")),
        Align(
            alignment: Alignment(0.25, -0.12),
            child: ImageMoveWidget(1500, "assets/images/img_meet_onestep.png")),
        Align(
            alignment: Alignment(-0.3, 0.13),
            child: ImageMoveWidget(2000, "assets/images/img_eat_onestep.png")),
      ],
    );
  }
}
