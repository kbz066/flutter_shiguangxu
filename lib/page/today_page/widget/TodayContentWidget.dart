import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';

import 'package:flutter_shiguangxu/widget/MyBehavior.dart';
import 'package:flutter_shiguangxu/widget/RefreshScrollPhysics.dart';

import 'TodayCircleWidget.dart';
import 'TodayPullListHeaderWidget.dart';

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
  double _handerContainerHeight = 100; //头部高度

  bool _arrivedListHeight = false;
  double _offsetRadio = 1.0; //阻尼值

  double _headerOffset = 0;

  PageController _pageController;
  ScrollController _headerController;
  ScrollPhysics _contentScrollPhysics;
  StreamSubscription<TodayContentIndexEvent> _eventStream;

  AnimationController _scrollAnimationController;

  Animation<double> _scrollAnimation;
  Tween<double> _scrollTween;
  _TodayContentWidgetState(this._initialPage);

  bool isReset = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: this._initialPage);
    _headerController = ScrollController(initialScrollOffset: 0);
    _contentScrollPhysics = AlwaysScrollableScrollPhysics();

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

    initAanimation();
  }

  @override
  void dispose() {
    _eventStream.cancel();

    super.dispose();
  }

  /// page滑动事件
  _onPageChanged(index) {
    //  print("index    _onPageChanged      $index    ${_isTouch}");
    if (_isTouch) {
      EventBusUtils.instance.eventBus
          .fire(TodayWeekCalendarIndexEvent((index / 7).floor(), index % 7));
      _isTouch = false;
    }

    ///重置

    setState(() {
      _isTouch = false;

      _isRunscrollAnimation = false;
      _handerContainerHeight = 100; //头部高度

      _arrivedListHeight = false;
      _offsetRadio = 1.0; //阻尼值

      _headerOffset = 0;
    });
  }

  ///外部监听 下拉事件
  _onPointerMove(PointerMoveEvent event) {}

  ///头部移动
  _headerTranslationY(double offset) {
    setState(() {
      if (_headerOffset + offset >= _handerContainerHeight) {
        _arrivedListHeight = true;
        _offsetRadio = 3;
      } else {
        _arrivedListHeight = false;
        _offsetRadio = 1;
      }
      if (offset < 0) {
        //头部显示并上滑
        _offsetRadio = 1;
      }

      _headerOffset += offset / _offsetRadio;
    });
  }

  void _handleOverscrollNotification(OverscrollNotification notification) {
    if (notification.dragDetails == null || notification.velocity != 0) {
      return;
    }
    if (notification.overscroll < 0.0) {
      _headerTranslationY(notification.dragDetails.delta.dy);
    }
  }

  void _handleUserScrollNotification(UserScrollNotification notification) {
    if (_headerOffset > 0 &&
        notification.direction == ScrollDirection.reverse &&
        !_isRunscrollAnimation) {
      //头部刷新布局出现反向滑动时（由下向上）

      setState(() {
        _contentScrollPhysics = RefreshScrollPhysics();
      });
    }
  }

  void _handleScrollUpdateNotification(ScrollUpdateNotification notification) {
    //当上拉加载时，不知道什么原因，dragDetails可能会为空，导致抛出异常，会发生很明显的卡顿，所以这里必须判空
    if (notification.dragDetails == null) {
      return;
    }

    //Header刷新的布局可见时，且当手指反方向拖动（由下向上），notification 为 ScrollUpdateNotification，这个时候让头部刷新布局的高度+delta.dy(此时dy为负数)
    // 来缩小头部刷新布局的高度，当完全看不见时，将scrollPhysics设置为RefreshAlwaysScrollPhysics，来保持ListView的正常滑动

    if (_headerOffset > 0) {
      //  如果头部的布局高度<0时，将topItemHeight=0；并恢复ListView的滑动
      if (_headerOffset + notification.dragDetails.delta.dy / _offsetRadio <
          0) {
        setState(() {
          _headerOffset = 0;
          _offsetRadio = 1;
          _contentScrollPhysics = AlwaysScrollableScrollPhysics();
        });
      } else {
        //当刷新布局可见时，让头部刷新布局的高度+delta.dy(此时dy为负数)，来缩小头部刷新布局的高度
        _contentScrollPhysics = RefreshScrollPhysics();

        _headerTranslationY(notification.dragDetails.delta.dy);
      }
    }
  }

  ///滑动结束
  void _handleScrollEndNotification(ScrollEndNotification notification) {
    startScrollAnimation();
  }

  startScrollAnimation() {
    if (_isRunscrollAnimation || _scrollAnimationController.isAnimating) {}

    if (_headerOffset.abs() == 0 ||
        _headerOffset.abs() == _handerContainerHeight) {
      setState(() {
        _contentScrollPhysics = AlwaysScrollableScrollPhysics();
      });
      return;
    }

    setState(() {
      _contentScrollPhysics = NeverScrollableScrollPhysics();
    });

    if (_headerOffset.abs() >= _handerContainerHeight / 2) {
      _scrollTween.begin = _headerOffset;
      _scrollTween.end = _handerContainerHeight;
    } else {
      _scrollTween.begin = _headerOffset;
      _scrollTween.end = 0;
    }

    _scrollAnimationController.forward();
  }

  void initAanimation() {
    _scrollAnimationController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    final Animation curve = CurvedAnimation(
        parent: _scrollAnimationController, curve: Curves.easeOut);
    _scrollTween = Tween(begin: 0.0, end: 1.0);
    _scrollAnimation = _scrollTween.animate(curve)
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
      })
      ..addListener(() {
        //因为animationController reset()后，addListener会收到监听，导致再执行一遍,会异常 所以用此标记
        //判断是reset的话就返回避免异常
        if (isReset) {
          return;
        }
        setState(() {
          _headerOffset = _scrollAnimation.value;
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
    print(
        "build            ${_headerOffset}         ${_handerContainerHeight}");
    return Container(
        width: double.infinity,
        child: Listener(
          onPointerDown: (event) {
            _isTouch = true;
          },
          onPointerMove: this._onPointerMove,
          child: PageView.builder(
            controller: _pageController,
            itemCount:
                DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: <Widget>[
                  Positioned(
                    top: _headerOffset - _handerContainerHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: <Widget>[
                        TodayPullListHeaderWidget(_handerContainerHeight,
                            _headerOffset, _arrivedListHeight),
                        NotificationListener(
                          onNotification: (ScrollNotification notification) {
                            if (_isRunscrollAnimation) {
                              return false;
                            }

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
                          child: Expanded(
                            child: ScrollConfiguration(
                              behavior:
                                  MyBehavior(false, true, Colors.blueAccent),
                              child: ListView(
                                physics: _contentScrollPhysics,
                                controller: _headerController,
                                children: [showEmptyContent(0)],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
            onPageChanged: this._onPageChanged,
          ),
        ));
  }

  showEmptyContent(index) {
    return Container(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/today_empty.png"),
//          Text(
//            "${index}",
//            style: TextStyle(color: Colors.red, fontSize: 16),
//          ),
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
