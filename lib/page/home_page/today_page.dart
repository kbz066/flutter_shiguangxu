import 'package:flutter/material.dart';

import 'package:flutter_shiguangxun/common/ColorUtils.dart';
import 'package:flutter_shiguangxun/widget/HomeWeekCalendarWidget.dart';

class ToDayPage extends StatefulWidget {
  @override
  _ToDayPageState createState() => _ToDayPageState();
}

class _ToDayPageState extends State<ToDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.mainColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: Column(
        children: <Widget>[
          _buildTopWidget(),
          HomeWeekCalendarWidget(),
          Transform(
            transform: Matrix4.translationValues(0, -10, 0),
            child: SizedBox(
              width: 60,
              child: Image.asset("assets/images/home_bg.png",),
            )
          )
        ],
      ),
    );
  }
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



