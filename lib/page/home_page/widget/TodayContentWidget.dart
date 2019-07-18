import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';
import 'package:flutter_shiguangxu/widget/RefreshScrollPhysics.dart';

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

  bool _isRunscrollAnimation = false;
  List _headerTitleList;

  List _headerImageList;
  double _handerContainerHeight; //头部高度
  double _handerScrollSize;
  double _offsetRadio; //阻尼值

  double _headerOffset;
  double _circlePercent;
  double _circleOpacity;
  double _headerListTranslationY;
  double _contentTranslationY;
  double _headerCircleTranslationY;
  double _shrinkTranslationY;

  PageController _pageController;
  ScrollController _headerController;
  ScrollPhysics _contentScrollPhysics;
  StreamSubscription<TodayContentIndexEvent> _eventStream;

  AnimationController _scrollAnimationController;

  Animation<double> _scrollAnimation;
  Tween<double> _scrollTween;
  _TodayContentWidgetState(this._initialPage);

  bool isReset = false;
  bool isPulling = false;

  @override
  void initState() {
    super.initState();

    _offsetRadio = 1.0;
    _circleOpacity = 1;
    _headerOffset = 0;
    _circlePercent = 0;
    _shrinkTranslationY = 0;
    _contentTranslationY = 0;
    _headerCircleTranslationY = 0;
    _handerScrollSize = 100;
    _handerContainerHeight = 100;
    _headerListTranslationY = -_handerScrollSize;
    _pageController = PageController(initialPage: this._initialPage);
    _headerController = ScrollController(initialScrollOffset: 0);
    _contentScrollPhysics = AlwaysScrollableScrollPhysics();
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
      //  print("打印     ${_headerController.position.activity.velocity}");
//      if ((_headerController.offset - _handerScrollSize).abs() <=
//          _handerScrollSize) {
//        setState(() {
//          _headerTranslationY();
//        });
//      }
    });

    initAanimation();
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
  _onPointerMove(PointerMoveEvent event) {}

  ///头部移动
  _headerTranslationY(double offset) {
//    print("_headerOffset         ${_headerOffset}");

    if (_headerOffset + offset <= _handerScrollSize * 2) {
      setState(() {
        _headerOffset += offset;

        double moreOffset = _headerOffset - _handerScrollSize;
        double percent = _headerOffset / (_handerScrollSize / 2);

        _handerContainerHeight-=offset/7;
        if (percent <= 1.0) {
          //  _headerListTranslationY = -_handerScrollSize / 2;
          _headerCircleTranslationY = _headerOffset;
          _circlePercent = percent;
          _circleOpacity =  1-percent * 0.8;
          print("  $_headerCircleTranslationY");
        } else {
          _circleOpacity = 0;
          double subPercent = (moreOffset) / (_handerScrollSize - _handerScrollSize / 2);

          subPercent = min(1.0, subPercent);
//      _headerCircleTranslationY = _handerScrollSize / 2 / 2 -
//          15 / 2 -
//          _handerScrollSize / 2 * subPercent / 2;
          //mExpendPoint.setPercent(1.0f);

          //float alpha = (1 - subPercent * 2);
          // mExpendPoint.setAlpha(Math.max(alpha, 0));

          _headerListTranslationY = -(1 - subPercent) * _handerScrollSize / 2;
         // print("_headerTranslationY      ${subPercent}  ${_headerListTranslationY}  $_headerOffset    $moreOffset   $offset");
        }

//        if (percent<=1) {
//
//          _circlePercent=percent;
//          _circleOpacity=1-percent/6;
//          _headerCircleTranslationY += offset / 2;
//
//        }else{
//          double subPercent = (moreOffset) / (_handerScrollSize - _handerScrollSize / 2);
//          _circleOpacity=0;
//          _headerListTranslationY+=offset;
//        }
        _contentTranslationY = _headerListTranslationY + _handerScrollSize;
      });
    }
  }

  void _handleOverscrollNotification(OverscrollNotification notification) {
    // print("notification                         ${notification.runtimeType}");
    if (notification.dragDetails == null) {
      return;
    }
    if (notification.overscroll < 0.0) {
      _headerTranslationY(notification.dragDetails.delta.dy);
    }
  }

  void _handleUserScrollNotification(UserScrollNotification notification) {
    if (_headerListTranslationY.abs() < _handerScrollSize &&
        notification.direction == ScrollDirection.reverse &&
        !_isRunscrollAnimation) {
      //头部刷新布局出现反向滑动时（由下向上）
      print(" ////头部刷新布局出现反向滑动时（由下向上    ");
      scrollPhysicsChanged(new RefreshScrollPhysics());
    }
  }

  void _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    //当上拉加载时，不知道什么原因，dragDetails可能会为空，导致抛出异常，会发生很明显的卡顿，所以这里必须判空
    if (notification.dragDetails == null) {
      return;
    }
    //Header刷新的布局可见时，且当手指反方向拖动（由下向上），notification 为 ScrollUpdateNotification，这个时候让头部刷新布局的高度+delta.dy(此时dy为负数)
    // 来缩小头部刷新布局的高度，当完全看不见时，将scrollPhysics设置为RefreshAlwaysScrollPhysics，来保持ListView的正常滑动

 //   print("ScrollUpdateNotification     ${_headerListTranslationY}   ${-_handerScrollSize}");

    if (_headerListTranslationY > -_handerScrollSize) {
      //  如果头部的布局高度<0时，将topItemHeight=0；并恢复ListView的滑动
      if (_headerListTranslationY + notification.dragDetails.delta.dy <
          -_handerScrollSize) {
        setState(() {
          _headerListTranslationY = -_handerScrollSize;
          _contentScrollPhysics = AlwaysScrollableScrollPhysics();
        });
      } else {
        //当刷新布局可见时，让头部刷新布局的高度+delta.dy(此时dy为负数)，来缩小头部刷新布局的高度
        _headerTranslationY(notification.dragDetails.delta.dy);
      }
    }
  }

  ///滑动结束
  void _handleScrollEndNotification(ScrollEndNotification notification) {
    print("_handleScrollEndNotification 结束");
    startScrollAnimation();
  }

  startScrollAnimation() {
    if (_headerListTranslationY.abs() == 0 ||
        _headerListTranslationY.abs() == _handerScrollSize) return;
    scrollPhysicsChanged(new NeverScrollableScrollPhysics());
    if (_headerListTranslationY.abs() > _handerScrollSize / 2) {
      _scrollTween.begin = _headerListTranslationY;

      _scrollTween.end = -_handerScrollSize;
      _headerOffset = 0;
    } else {
      _scrollTween.begin = _headerListTranslationY;

      _scrollTween.end = 0;
      _headerOffset = _handerScrollSize;
    }

    _scrollAnimationController.forward();
  }

  void initAanimation() {
    _scrollAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _scrollTween = Tween(begin: 0.0, end: 1.0);
    _scrollAnimation = _scrollTween.animate(_scrollAnimationController)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          //动画结束
          isReset = true;
          _scrollAnimationController.reset();
          isReset = false;
          _isRunscrollAnimation = false;
          scrollPhysicsChanged(AlwaysScrollableScrollPhysics());
        } else if (state == AnimationStatus.forward) {
          _isRunscrollAnimation = true;
        }
        // print("动画-----》 $state     ${_shrinkTranslationY}   $_headerListTranslationY" );
      })
      ..addListener(() {
        //因为animationController reset()后，addListener会收到监听，导致再执行一遍,会异常 所以用此标记
        //判断是reset的话就返回避免异常
        if (isReset) {
          return;
        }
        setState(() {
          // print("动画---addListener  --》 ${_scrollAnimation.value}" );

          _headerListTranslationY = _scrollAnimation.value;
          _contentTranslationY = _headerListTranslationY + _handerScrollSize;
        });
      });
  }

  scrollPhysicsChanged(Physics) {
    setState(() {
      _contentScrollPhysics = Physics;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("build      ${_headerListTranslationY}");

    // print(" build    ${_headerListTranslationY}     ${_contentTranslationY}    ${_contentScrollPhysics}");
    return Container(
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount:
            DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
        itemBuilder: (BuildContext context, int index) {
          return Listener(
              onPointerMove: this._onPointerMove,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(),
                  ),
                  Positioned(
                    top: _contentTranslationY,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        ScrollMetrics metrics = notification.metrics;
                        if (notification is ScrollUpdateNotification) {
                          _handleScrollUpdateNotification(notification);
                        } else if (notification is ScrollEndNotification) {
                          _handleScrollEndNotification(notification);
                        } else if (notification is UserScrollNotification) {
                          _handleUserScrollNotification(notification);
                        } else if (metrics.atEdge &&
                            notification is OverscrollNotification) {
                          _handleOverscrollNotification(notification);
                        }
                        return true;
                      },
                      child: ListView(
                        physics: _contentScrollPhysics,
                        controller: _headerController,
                        children: List.generate(200, (index) {
                          return Text("$index");
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                      top: _headerListTranslationY,
                      left: 0,
                      right: 0,
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.only(left: 40),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
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
                              opacity: _circleOpacity,
                              child: TodayCircleWidget(_circlePercent),
                            )
                          ],
                        ),
                      )),
//                  Positioned(
//                    top: _headerCircleTranslationY,
//                    left: 0,
//                    right: 0,
//                    child:
//             ,
//                  )
                ],
              ));
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
