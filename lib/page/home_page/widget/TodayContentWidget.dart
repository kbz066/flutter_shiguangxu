import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';

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
  StreamSubscription<TodayContentIndexEvent> _eventStream;

  PageController _Controller;

  _TodayContentWidgetState(this._initialPage);

  @override
  void initState() {
    super.initState();
    _Controller = PageController(initialPage: this._initialPage);


    _eventStream = EventBusUtils.instance.eventBus
        .on<TodayContentIndexEvent>()
        .listen((event) {
      print("订阅收到     ${event.pageIndex}");
      setState(() {
//        _Controller.jumpToPage(event.pageIndex);
        _Controller.animateToPage(event.pageIndex,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
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
//    print("打印  ${index}   ${_isTouch}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Listener(
        onPointerDown: (PointerDownEvent event) {

          _isTouch = true;
        },
        child: PageView.builder(
          controller: _Controller,
          itemCount:
              DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs(),
          itemBuilder: (BuildContext context, int index) {
            return showEmptyContent(index);
          },
          onPageChanged: this._onPageChanged,
        ),
      ),
    );
  }

  showEmptyContent(index) {
    return Column(
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
    );
  }
}
