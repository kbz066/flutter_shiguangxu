import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/TodayMoveTriangleWidget.dart';

class HomeWeekCalendarWidget extends StatefulWidget {
  WeekCalendarInfo _weekCalendarInfo;

  HomeWeekCalendarWidget(this._weekCalendarInfo);

  @override
  HomeWeekCalendarWidgetState createState() =>
      HomeWeekCalendarWidgetState(_weekCalendarInfo);
}

class HomeWeekCalendarWidgetState extends State<HomeWeekCalendarWidget> {
  bool _isTouch = false;
  WeekCalendarInfo _weekCalendarInfo;

  PageController _transController;

  StreamSubscription<TodayWeekCalendarIndexEvent> _eventStream;

  HomeWeekCalendarWidgetState(this._weekCalendarInfo);

  void initState() {
    super.initState();

    _transController = new PageController();

    ///eventbus 通信
    _eventStream = EventBusUtils.instance.eventBus
        .on<TodayWeekCalendarIndexEvent>()
        .listen((event) {

      setState(() {
        this._weekCalendarInfo.currentWeekIndex = event.weekIndex;
        this._weekCalendarInfo.currentPageIndex = event.pageIndex;
        _transController.animateToPage(event.pageIndex,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      });
    });
  }

  @override
  void dispose() {
    _eventStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _isTouch = true;
      },
      child: Container(
        color: ColorUtils.mainColor,
        height: 55,
        child: PageView.builder(
          controller: _transController,
          itemCount: (_weekCalendarInfo._dateTotalSize / 7).ceil(),
          itemBuilder: (BuildContext context, int pageIndex) {
            return Stack(
              children: <Widget>[
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _weekCalendarInfo.weekTitles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7, childAspectRatio: 0.5),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text("${_weekCalendarInfo.weekTitles[index]}",
                            style: TextStyle(color: Colors.white70)),
                        InkWell(
                          onTap: () {
                            print("点击的 index   ${index}    ${pageIndex}   ");
                            setState(() {
                              _weekCalendarInfo._currentWeekIndex = index;
                              _weekCalendarInfo.currentPageIndex = pageIndex;
                              EventBusUtils.instance.eventBus.fire(
                                  TodayContentIndexEvent(
                                      pageIndex * 7 + index));
                            });
                          },
                          child: _getTimeWidget(
                              _weekCalendarInfo._currentTime, index, pageIndex),
                        )
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: HomeMoveTriangleWidget(EdgeInsets.only(
                      left: _weekCalendarInfo._currentWeekIndex *
                          _getWeekItemWidth())),
                )
              ],
            );
          },
          onPageChanged: _onPageChanged,
        ),
      ),
    );
  }

  _onPageChanged(index) {
    if (_isTouch) {
      print("_onPageChanged    " + index.toString());

      if (index == _weekCalendarInfo.currentPageIndex) {
        return;
      }
      setState(() {
        if (_weekCalendarInfo.currentPageIndex < index) {
          _weekCalendarInfo._currentWeekIndex = 0;
        } else {
          _weekCalendarInfo._currentWeekIndex = 6;
        }

        _weekCalendarInfo.currentPageIndex = index;
        EventBusUtils.instance.eventBus.fire(TodayContentIndexEvent(
            index * 7 + _weekCalendarInfo.currentWeekIndex));
      });

      print("index      " + index.toString());
      _isTouch = false;
    }
  }

  _getTimeWidget(_time, index, pageIndex) {
    /**
     * 当前显示的日期
     */
    var _nowDuration =
        _time.add(Duration(days: pageIndex * 7 + index - (_time.weekday - 1)));
    return _time.compareTo(_nowDuration) == 0
        ? Container(
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isCheckIndex(index, pageIndex) ? Colors.white : null,
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle),
            child: Text("今",
                style: TextStyle(
                    color: isCheckIndex(index, pageIndex)
                        ? ColorUtils.mainColor
                        : Colors.white70,
                    textBaseline: TextBaseline.ideographic)),
          )
        : Container(
            height: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isCheckIndex(index, pageIndex) ? Colors.white : null,
                shape: BoxShape.circle),
            child: Text("${(_nowDuration.day.toString())}",
                style: TextStyle(
                    color: isCheckIndex(index, pageIndex)
                        ? ColorUtils.mainColor
                        : Colors.white70)),
          );
  }

  isCheckIndex(index, pageIndex) {
    return _weekCalendarInfo.currentPageIndex == pageIndex &&
        _weekCalendarInfo._currentWeekIndex == index;
  }

  double _getWeekItemWidth() {
    return window.physicalSize.width / window.devicePixelRatio / 7;
  }
}

class WeekCalendarInfo {
  var weekTitles;
  var currentPageIndex;
  var _currentTime;
  var _dateTotalSize;

  var _currentWeekIndex;

  WeekCalendarInfo(
      this._currentTime, this._dateTotalSize, this._currentWeekIndex,
      {this.weekTitles = const ["一", "二", "三", "四", "五", "六", "日"],
      this.currentPageIndex = 0});
  get currentTime => _currentTime;
  get dateTotalSize => _dateTotalSize;

  get currentWeekIndex => _currentWeekIndex;

  set currentWeekIndex(value) {
    _currentWeekIndex = value;
  }
}
