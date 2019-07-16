import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';

import 'TodayCircleWidget.dart';

class TodayContentWidget extends StatefulWidget {
  var _initialPage;

  TodayContentWidget(this._initialPage);

  @override
  _TodayContentWidgetState createState() =>
      _TodayContentWidgetState(this._initialPage);
}

class _TodayContentWidgetState extends State<TodayContentWidget>
    with TickerProviderStateMixin {
  var _initialPage;

  bool _isTouch = false;

  List _headerTitleList;

  List _headerImageList;
  double _handerContainerHeight; //头部高度
  double _handerMaxContainerHeight;
  double _handerScrollSize;
  double _offsetRadio; //阻尼值
  double _initOffset;

  double _headerOffset;

  double _circleOpacity;
  double _headerListTranslationY;
  double _headerCircleTranslationY;
  double _contentTranslationY;
  PageController _pageController;
  ScrollController _headerController;

  StreamSubscription<TodayContentIndexEvent> _eventStream;

  _TodayContentWidgetState(this._initialPage);

  @override
  void initState() {
    super.initState();
    _circleOpacity = 0;
    _offsetRadio = 2.0;


    _headerListTranslationY = 0;
    _headerCircleTranslationY = 0;
    _handerScrollSize = 200;
    _handerContainerHeight = 100;
    _headerOffset = 0;
    _contentTranslationY=0;
    _handerMaxContainerHeight = _handerScrollSize * 2;
    _pageController = PageController(initialPage: this._initialPage);
    _headerController =
        ScrollController(initialScrollOffset: _handerScrollSize);

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
      setState(() {
        //_headerTranslationY();
      });
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
  _onPointerUp(PointerUpEvent event) {
    if (0 < _headerController.offset &&
        _headerController.offset < _handerScrollSize) {
      if (_headerController.offset < _initOffset) {
        //上滑
//        print("下滑------------->  ${(_headerController.offset-_handerScrollSize).abs()}");
        if ((_headerController.offset - _handerScrollSize).abs() >=
            _handerScrollSize / 2) {
          _headerController.animateTo(0,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        } else {
          _headerController.animateTo(_handerScrollSize,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        }
      } else {
        if ((_headerController.offset).abs() > _handerScrollSize / 3) {
          _headerController.animateTo(_handerScrollSize,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        } else {
          _headerController.animateTo(0,
              duration: Duration(milliseconds: 200), curve: Curves.easeOut);
        }

//        print("上滑------------->   ${(_headerController.offset-_handerScrollSize).abs()}   ${_headerController.offset}");
      }
    } else {
      _startAni();
    }
  }

  _onPointerDown(PointerDownEvent event) {
    _initOffset = _headerController.offset;
  }

  _onPointerMove(PointerMoveEvent event) {
    if ((_headerController.offset - _handerScrollSize).abs() >=
            _handerScrollSize &&
        _handerContainerHeight <= _handerMaxContainerHeight) {
      //放大

      setState(() {
        if (_handerContainerHeight >= _handerMaxContainerHeight * 0.8) {
          _offsetRadio = 3.0;
        }

        _handerContainerHeight += event.delta.dy / _offsetRadio;
      });
    }
  }

  ///头部移动
  _headerTranslationY(double overscroll) {
    _headerOffset-=overscroll;
    double percent = _headerOffset.abs()/ (_handerScrollSize/2);

    double moreOffset = _headerOffset.abs() - _handerScrollSize/2;


    if (percent <= 1.0) {
//      mExpendPoint.setPercent(percent);
//      mExpendPoint.setTranslationY(-_headerOffset.abs()/ 2 + mExpendPoint.getHeight() / 2);
     _headerListTranslationY= _handerScrollSize/2;
    }else {
      double subPercent = (moreOffset) / (_handerScrollSize - _handerScrollSize/2);

      print("subPercent            $subPercent    $moreOffset");
      subPercent = min(1.0, subPercent);

      double alpha = (1 - subPercent * 2);

      _headerListTranslationY =(1 - subPercent) * _handerScrollSize/2;
    }

  }

  _startAni() {
    final AnimationController controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        new CurvedAnimation(parent: controller, curve: Curves.easeOut);
    Animation<double> height =
        new Tween(begin: _handerContainerHeight, end: _handerScrollSize)
            .animate(curve);
    height.addListener(() {
      setState(() {
        _handerContainerHeight = height.value;
      });
    });
    controller.forward();
  }

  bool _onNotification(notification){

    switch (notification.runtimeType) {
      case ScrollStartNotification:
       // print("开始滚动");
        break;
      case ScrollUpdateNotification:
        ScrollUpdateNotification scrollUpdateNotification=notification;

        //print("正在滚动 ");
        break;
      case ScrollEndNotification:
        ScrollEndNotification endNotification =notification;
        //下滑到最底部
        if (notification.metrics.extentAfter == 0.0) {
          // print('======下滑到最底部======');

        }
        //滑动到最顶部
        if (notification.metrics.extentBefore == 0.0) {
          // print('======滑动到最顶部======');

        }
        //print("滚动停止  ${ endNotification.metrics }");
        break;
      case OverscrollNotification:
        OverscrollNotification overscrollNotification=notification;

        setState(() {
          _headerTranslationY(overscrollNotification.overscroll);
        });
       // print("滚动到边界  ${overscrollNotification.overscroll}");
        break;


    }
    return true;
  }
  @override
  Widget build(BuildContext context) {


    print("_headerListTranslationY    ${_headerListTranslationY}");
    return Container(
        width: double.infinity,
        child: Listener(
          onPointerDown: (PointerDownEvent details) {
            _isTouch = true;
            print("onTapDown");
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount:
                DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
            itemBuilder: (BuildContext context, int index) {
              return
                NotificationListener(
                  onNotification: this._onNotification,
                  child: Stack(

                    children: <Widget>[
                      Positioned(
                        top: _contentTranslationY,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ListView(
                          children: <Widget>[showEmptyContent(0)],
                        ),
                      ),
                      Positioned(
                        top: _headerListTranslationY-_handerScrollSize/2,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: Colors.red,

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
                                              SizedBox(height: 10,),
                                              Image.asset("assets/images/${_headerImageList[index]}"),
                                              SizedBox(height: 10,),
                                              Text("${_headerTitleList[index]}")
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),

                            ],
                          ),
                          height: _handerContainerHeight,
                        ),
                      ),
                      Positioned(
                        top: _headerCircleTranslationY,

                        left: 0,
                        right: 0,

                        child: TodayCircleWidget(0.8),
                      )
                    ],
                  ),
                );
            },
            onPageChanged: this._onPageChanged,
          ),
        ));
  }

  showEmptyContent(index) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.only(top: 100),
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
