import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/Constant.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/TodayContentWidget.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/TodayWeekCalendarWidget.dart';
import 'package:flutter_shiguangxu/widget/BottomPopupRoute.dart';
import 'package:flutter_shiguangxu/widget/InkWellImageWidget.dart';
import 'package:flutter_shiguangxu/widget/NumberPicker.dart';

import 'package:flutter_shiguangxu/widget/TextPagerIndexBar.dart'
    hide TabBarView;

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

  _showAddPlanDialog() {
    var contentKey = GlobalKey();
    var labels = ["今天", "明天", "后天", "大后天", "下周"].map((item) {
      return Container(
        width: item.length * 25.toDouble(),
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white),
        child: Text(
          "$item",
          style: TextStyle(),
        ),
      );
    }).toList();

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
          child: Scaffold(
            backgroundColor: Colors.black12,
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                key: contentKey,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: labels,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "写点什么,吧事情记录下来....",
                                    hintStyle: TextStyle(color: Colors.black26),
                                  ),
                                ),
                              ),
                              Image.asset(Constant.IMAGE_PATH +
                                  "icon_add_voice_nor.png")
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Color.fromARGB(255, 250, 250, 250),
                          child: Row(
                            children: <Widget>[
                              InkWellImageWidget("plant_icon_time", () {
                                _showTimeDialog();
                              }),
                              SizedBox(
                                width: 30,
                              ),
                              InkWellImageWidget(
                                  "icon_add_category_nor", () {}),

                              SizedBox(
                                width: 30,
                              ),
                              InkWellImageWidget(
                                  "icon_add_important_nor", () {}),

                              //
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }

  _showTimeDialog() {
    var tabs = ["时间点", "时间段", "全天"];
    var _tabController = TabController(length: 3, vsync: this);

    showDialog(
      context: context,
      builder: (ctx) {
        return Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Container(
              width: WindowUtils.getWidthDP() * 0.9,
              height: WindowUtils.getHeightDP() * 0.65,
              padding: EdgeInsets.only(top: 20),

              decoration: BoxDecoration(
                color: Colors.white, // 底色

                borderRadius: BorderRadius.circular((15.0)), // 圆角度
              ), //
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 34,
                    width: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffdddddd)), // 边色与边宽度

                        //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                        borderRadius: BorderRadius.all(
                            Radius.circular(17))), // 也可控件一边圆角大小
                    child: TextPagerIndexBar(
                      indicatorWeight: 10,
                      circular: 15,
                      unselectedLabelColor: Color(0xffdddddd),
                      indicatorColor: Color(0xff6495ED),
                      indicatorPadding: EdgeInsets.all(50),
                      controller: _tabController,
                      tabs: tabs.map((item) {
                        return Text(item);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        _timePointPage(),
                        _timePointPage(),
                        _timePointPage(),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                      border: Border(
                          top: BorderSide(color: Colors.black12, width: 1)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},

                            padding: EdgeInsets.all(0),
                            child: Text("修改日期",style: TextStyle(color: Colors.blue,fontSize: 16)),
                          ),
                        ),
                        Container(
                          color: Colors.black12,
                          width: 1,
                          height:50,
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {},

                            child: Text("保存",style: TextStyle(color: Colors.blue,fontSize: 16)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _timePointPage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(),
                child: Text("我是第一个页面"),
              ),
              Picker(
                  itemExtent: 40,
                  height: 200,
                  looping: true,
                  adapter: NumberPickerAdapter(data: [
                    NumberPickerColumn(begin: 0, end: 0),
                    NumberPickerColumn(begin: 0, end: 23),
                    NumberPickerColumn(begin: 0, end: 55, jump: 5),
                    NumberPickerColumn(begin: 0, end: 0),
                  ]),
                  hideHeader: true,
                  title: Text("Please Select"),
                  selectedTextStyle:
                      TextStyle(color: Colors.blue, fontSize: 30),
                  onConfirm: (Picker picker, List value) {
                    print(value.toString());
                    print(picker.getSelectedValues());
                  }).makePicker(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorUtils.mainColor,
        onPressed: () {
          _showAddPlanDialog();
        },
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
