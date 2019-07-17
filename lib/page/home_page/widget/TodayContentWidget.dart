import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';

import 'Test.dart';
import 'TodayCircleWidget.dart';

class TodayContentWidget extends StatefulWidget {
  var _initialPage;

  TodayContentWidget(this._initialPage);

  @override
  _TodayContentWidgetState createState() =>
      _TodayContentWidgetState(this._initialPage);
}

class _TodayContentWidgetState extends State<TodayContentWidget> {
  var _initialPage;

  bool _isTouch = false;

  List _headerTitleList;

  List _headerImageList;
  double _handerContainerHeight; //头部高度
  double _handerScrollSize;
  double _offsetRadio; //阻尼值

  double _headerOffset;

  double _headerListTranslationY;
  double _headerCircleTranslationY;

  PageController _pageController;
  ScrollController _headerController;

  StreamSubscription<TodayContentIndexEvent> _eventStream;

  _TodayContentWidgetState(this._initialPage);

  @override
  void initState() {
    super.initState();

    _offsetRadio = 1.0;

    _headerOffset = 0;
    _headerListTranslationY = 0;
    _headerCircleTranslationY = 0;
    _handerScrollSize = 120;
    _handerContainerHeight = 120;
    _pageController = PageController(initialPage: this._initialPage);
    _headerController = ScrollController(initialScrollOffset: 120);

    _headerTitleList = [
      "天气",
      "生理期",
      "记账",
      "专注",
      "纪念日",
      "日总结",
      "生日",
      "倒数日",
      "万年历",
      "闹钟",
      "还款提醒"
    ];
    _headerImageList = [
      "tool_icon_weather.png",
      "icon_menstruation.png",
      "icon_bookkeeping.png",
      "icon_focus.png",
      "icon_jnr.png",
      "icon_summary.png",
      "tool_icon_day.png",
      "icon_dsr.png",
      "tool_icon_calendar.png",
      "tool_icon_clock.png",
      "icon_card.png"
    ];

    _eventStream = EventBusUtils.instance.eventBus
        .on<TodayContentIndexEvent>()
        .listen((event) {
      print("订阅收到     ${event.pageIndex}");
      setState(() {
//        _Controller.jumpToPage(event.pageIndex);
        _pageController.animateToPage(event.pageIndex,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      });
    });
    _headerController.addListener(() {
      if ((_headerController.offset - _handerScrollSize).abs() <=
          _handerScrollSize) {
        setState(() {
          _headerTranslationY();
        });
      }
    });
  }

  @override
  void dispose() {
    _eventStream.cancel();
    super.dispose();
  }

  /// page滑动事件
  _onPageChanged(index) {
    if (_isTouch) {
      EventBusUtils.instance.eventBus
          .fire(TodayWeekCalendarIndexEvent((index / 7).floor(), index % 7));
      _isTouch = false;
    }
  }

  ///外部监听 下拉事件
  _onPointerMove(PointerMoveEvent event) {


  }


  ///头部移动
  _headerTranslationY() {
    _headerOffset = (_headerController.offset - _handerScrollSize).abs();
    double moreOffset = _headerOffset - _handerScrollSize / 2;
    double percent = _headerOffset / (_handerScrollSize / 2);
    if (percent <= 1.0) {
      _headerListTranslationY = _handerScrollSize / 2;
      _headerCircleTranslationY = -_headerOffset / 2 - 15 / 2;

      // print("_headerController      ${_headerCircleTranslationY}  ${_headerListTranslationY}");
    }
    else {
      double subPercent = (moreOffset) /
          (_handerScrollSize - _handerScrollSize / 2);


      subPercent = min(1.0, subPercent);
      _headerCircleTranslationY = _handerScrollSize / 2 / 2 - 15 / 2 -
          _handerScrollSize / 2 * subPercent / 2;
      //mExpendPoint.setPercent(1.0f);


      //float alpha = (1 - subPercent * 2);
      // mExpendPoint.setAlpha(Math.max(alpha, 0));


      _headerListTranslationY = (1 - subPercent) * _handerScrollSize / 2;
    }
//  }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount:
        DateTime
            .now()
            .difference(DateTime(2020, 12, 31))
            .inDays
            .abs(),
        itemBuilder: (BuildContext context, int index) {
          return Listener(
            onPointerMove: this._onPointerMove,
            child: CustomScrollView(
              physics: RefreshScrollPhysics(),
              controller: _headerController,
              slivers: <Widget>[
                // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹

                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.red,
                    height: _handerContainerHeight,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(

                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 11,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Image.asset(
                                              "assets/images/${_headerImageList[index]}"),
                                        ),
                                        Text("${_headerTitleList[index]}")
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0, _headerCircleTranslationY, 0),
                            child: TodayCircleWidget(
                                _headerOffset / (_handerScrollSize / 2) <= 1.0
                                    ? _headerOffset / (_handerScrollSize / 2)
                                    : 1.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SliverList(
                  delegate: new SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Text("$index");
                    },
                  ),
                )
              ],
            ),
          );
        },
        onPageChanged: this._onPageChanged,
      ),
    );
  }


  showEmptyContent(index) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/today_empty.png"),
          Text(
            "${index}",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "今天还没有日程安排吖！",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Text(
            "未来可期，提前做好日程安排",
            style: TextStyle(color: Colors.black26, fontSize: 14),
          )
        ],
      ),
    );
  }

}
