import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/SchedulePresenter.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/ScheduleDatePresenter.dart';

import 'package:flutter_shiguangxu/widget/PullListHeaderdart.dart';
import 'package:provider/provider.dart';

import 'RefreshScrollPhysics.dart';

class PullListView extends StatefulWidget {
  final int initialPage;
  final double handerContainerHeight;
  final Widget contentChild;
  final Widget handerChild;
  final Function(ScrollPhysics) scrollPhysicsChanged;

  PullListView(
      {@required this.initialPage,
      @required this.handerContainerHeight,
      @required this.contentChild,
      @required this.handerChild,
      @required this.scrollPhysicsChanged});

  @override
  _PullListViewState createState() => _PullListViewState();
}

class _PullListViewState extends State<PullListView>
    with TickerProviderStateMixin {
  bool _isEvent= false;
  bool isReset = false;
  bool _isRunscrollAnimation = false;
  bool _arrivedListHeight = false;

  double _offsetRadio = 1.0; //阻尼值
  double _headerOffset = 0;

  PageController _pageController;

  AnimationController _scrollAnimationController;
  Animation<double> _scrollAnimation;
  Tween<double> _scrollTween;

  StreamSubscription<TodayContentIndexEvent> _eventStream;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPage);

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

          widget.scrollPhysicsChanged(AlwaysScrollableScrollPhysics());
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

    initEventBus();
    super.initState();
  }

  @override
  void dispose() {
    _eventStream.cancel();
    _pageController.dispose();
    _scrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: _headerOffset - widget.handerContainerHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: <Widget>[
                  PullListHeader(widget.handerContainerHeight, _headerOffset,
                      _arrivedListHeight, widget.handerChild),
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
                      child: widget.contentChild,
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
      onPageChanged: this._onPageChanged,
    );
  }

  /// page滑动事件
  _onPageChanged(index) {

    if (!_isEvent) {

      EventBusUtils.instance.eventBus
          .fire(TodayWeekCalendarIndexEvent((index / 7).floor(), index % 7));
      _isEvent = false;
    }

    ///重置

    setState(() {
      _isEvent = false;

      _isRunscrollAnimation = false;
      _arrivedListHeight = false;
      _offsetRadio = 1.0; //阻尼值

      _headerOffset = 0;
    });
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
          widget.scrollPhysicsChanged(AlwaysScrollableScrollPhysics());
        });
      } else {
        //当刷新布局可见时，让头部刷新布局的高度+delta.dy(此时dy为负数)，来缩小头部刷新布局的高度

        widget.scrollPhysicsChanged(RefreshScrollPhysics());
        _headerTranslationY(notification.dragDetails.delta.dy);
      }
    }
  }

  ///滑动结束
  void _handleScrollEndNotification(ScrollEndNotification notification) {
    startScrollAnimation();
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

      widget.scrollPhysicsChanged(RefreshScrollPhysics());
    }
  }

  startScrollAnimation() {
    if (_isRunscrollAnimation || _scrollAnimationController.isAnimating) {}

    if (_headerOffset.abs() == 0 ||
        _headerOffset.abs() == widget.handerContainerHeight) {
      widget.scrollPhysicsChanged(AlwaysScrollableScrollPhysics());
      return;
    }

    widget.scrollPhysicsChanged(NeverScrollableScrollPhysics());
    if (_headerOffset.abs() >= widget.handerContainerHeight / 2) {
      _scrollTween.begin = _headerOffset;
      _scrollTween.end = widget.handerContainerHeight;
    } else {
      _scrollTween.begin = _headerOffset;
      _scrollTween.end = 0;
    }

    _scrollAnimationController.forward();
  }

  ///头部移动
  _headerTranslationY(double offset) {
    setState(() {
      if (_headerOffset + offset >= widget.handerContainerHeight) {
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

  void initEventBus() {
    _eventStream = EventBusUtils.instance.eventBus
        .on<TodayContentIndexEvent>()
        .listen((event) {
      _isEvent=true;
      print("订阅收到     ${event.pageIndex}");
      _pageController.animateToPage(event.pageIndex,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }
}
