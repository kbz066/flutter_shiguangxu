import 'dart:ui';

import 'package:flustars/flustars.dart';

import 'package:flutter/material.dart';


import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/today_page/widget/TodayAddPlanDialog.dart';

import 'package:flutter_shiguangxu/widget/BottomPopupRoute.dart';
import 'package:flutter_shiguangxu/widget/PopupWindow.dart';

import 'widget/TodayContentWidget.dart';
import 'widget/TodayWeekCalendarWidget.dart';

class ToDayPage extends StatefulWidget {
  @override
  _ToDayPageState createState() => _ToDayPageState();
}

class _ToDayPageState extends State<ToDayPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  EdgeInsetsTween _tween;

  Animation<EdgeInsets> _animation;

  AnimationController _controller;

  double lastMoveIndex = 0;

  WeekCalendarInfo _weekCalendarInfo;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _tween = new EdgeInsetsTween(
        begin: EdgeInsets.only(left: 0.0), end: EdgeInsets.only(left: 0.0));
    _animation = _tween.animate(_controller);

    _animation.addStatusListener((AnimationStatus status) {});

    _weekCalendarInfo = WeekCalendarInfo(
      DateTime.now(),
      DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
      DateTime.now().weekday - 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "today",
        backgroundColor: ColorUtils.mainColor,
        onPressed: () => _showAddPlanDialog(),
        child: Icon(Icons.add),
      ),
      backgroundColor: Color.fromARGB(255, 249, 250, 252),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTopWidget(),
          HomeWeekCalendarWidget(this._weekCalendarInfo),
          Expanded(
            child: Listener(
              onPointerMove: (PointerMoveEvent details) {},
              child: TodayContentWidget(
                  this._weekCalendarInfo.currentPageIndex * 7 +
                      this._weekCalendarInfo.currentWeekIndex),
            ),
          )
        ],
      ),
    );
  }

  _showAddPlanDialog() {
    var contentKey = GlobalKey();

    LogUtil.e(
        "打印下日期     ${this._weekCalendarInfo.currentPageIndex * 7 + this._weekCalendarInfo.currentWeekIndex}  ${_weekCalendarInfo.currentTime.weekday}");
    Navigator.push(
        context,
        BottomPopupRoute(
            child: GestureDetector(
          onTapDown: (down) {
            if (down.globalPosition.dy <
                WindowUtils.getHeightDP() -
                    contentKey.currentContext.size.height) {
              Navigator.pop(context);
            }
          },
          child: TodayAddPlanDialog(
              contentKey,
              DateTime.now().add(Duration(
                  days: _weekCalendarInfo.currentPageIndex * 7 +
                      _weekCalendarInfo.currentWeekIndex -
                      (_weekCalendarInfo.currentTime.weekday - 1)))),
        )));
  }

  _showSuccessDialog(String title) {
    PopupWindow.showDialog(context, 2000, this, (context) {
      return Material(
        color: Color.fromARGB(230, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          decoration: BoxDecoration(),
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Image.asset(Constant.IMAGE_PATH + "add_icon_hook.png"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  Text(
                    "清单添加成功",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(title,
                      style: TextStyle(fontSize: 16, color: Colors.black))
                ],
              )
            ],
          ),
        ),
      );
    }, top: 35, left: 10, right: 10);
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
                      padding: EdgeInsets.only(
                          left: 20, top: 5, right: 20, bottom: 5),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
