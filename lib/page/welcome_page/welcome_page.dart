import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_shiguangxu/common/NavigatorUtils.dart';
import 'package:flutter_shiguangxu/page/login_page/login_page.dart';
import 'package:flutter_shiguangxu/page/login_page/presenter/LoginPresenter.dart';
import 'package:flutter_shiguangxu/widget/ImageMoveWidget.dart';
import 'package:provider/provider.dart';

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
                NavigatorUtils.pushReplacement(
                    context,
                    ChangeNotifierProvider.value(
                      value: LoginPresenter(),
                      child: LoginPage(),
                    ));
              },
            )),
        Align(
            alignment: Alignment(-0.5, -0.39),
            child: ImageMoveWidget(
                1000, 0.5, "assets/images/img_buy_onestep.png")),
        Align(
            alignment: Alignment(0.25, -0.12),
            child: ImageMoveWidget(
                1500, 0.6, "assets/images/img_meet_onestep.png")),
        Align(
            alignment: Alignment(-0.3, 0.13),
            child: ImageMoveWidget(
                2000, 0.8, "assets/images/img_eat_onestep.png")),
      ],
    );
  }
}
