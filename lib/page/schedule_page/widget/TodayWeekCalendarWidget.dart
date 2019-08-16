import 'dart:async';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/common/WindowUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayWeekCalendarIndexEvent.dart';
import 'package:flutter_shiguangxu/page/schedule_page/presenter/WeekPresenter.dart';
import 'package:provider/provider.dart';

import 'TodayMoveTriangleWidget.dart';

class HomeWeekCalendarWidget extends StatefulWidget {
  HomeWeekCalendarWidget();

  @override
  HomeWeekCalendarWidgetState createState() => HomeWeekCalendarWidgetState();
}

class HomeWeekCalendarWidgetState extends State<HomeWeekCalendarWidget> {
  bool _isTouch = false;

  PageController _transController;

  StreamSubscription<TodayWeekCalendarIndexEvent> _eventStream;

  void initState() {
    _transController = new PageController();

    ///eventbus 通信
    _eventStream = EventBusUtils.instance.eventBus
        .on<TodayWeekCalendarIndexEvent>()
        .listen((event) {
      print("TodayWeekCalendarIndexEvent      $event");

      Provider.of<WeekPresenter>(context, listen: false)
          .setIndex(event.pageIndex, event.weekIndex);
      _transController.animateToPage(event.pageIndex,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });

    super.initState();
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
        child: Consumer<WeekPresenter>(builder: (context, value, child) {
          return PageView.builder(
            controller: _transController,
            itemCount: (value.dateTotalSize / 7).ceil(),
            itemBuilder: (BuildContext context, int pageIndex) {
              return Stack(
                children: <Widget>[
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: value.weekTitles.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7, childAspectRatio: 0.5),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Text("${value.weekTitles[index]}",
                              style: TextStyle(color: Colors.white70)),
                          InkWell(
                            onTap: () {
                              value.setIndex(pageIndex, index);
                              EventBusUtils.instance.eventBus.fire(
                                  TodayContentIndexEvent(
                                      pageIndex * 7 + index));
                            },
                            child: _getTimeWidget(
                                value.currentTime, index, pageIndex, value),
                          )
                        ],
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    child: HomeMoveTriangleWidget(EdgeInsets.only(
                        left: value.currentWeekIndex * _getWeekItemWidth())),
                  )
                ],
              );
            },
            onPageChanged: _onPageChanged,
          );
        }),
      ),
    );
  }

  _onPageChanged(index) {
    var weekPresenter = Provider.of<WeekPresenter>(context, listen: false);
    if (_isTouch) {
      print("_onPageChanged    " + index.toString());

      if (index == weekPresenter.currentPageIndex) {
        return;
      }
      if (weekPresenter.currentPageIndex < index) {
        weekPresenter.setIndex(index, 0);
      } else {
        weekPresenter.setIndex(index, 6);
      }

      EventBusUtils.instance.eventBus.fire(
          TodayContentIndexEvent(index * 7 + weekPresenter.currentWeekIndex));

      print("index      " + index.toString());
      _isTouch = false;
    }
  }

  _getTimeWidget(_time, index, pageIndex, WeekPresenter value) {
    /**
     * 当前显示的日期
     */
    var _nowDuration =
        _time.add(Duration(days: pageIndex * 7 + index - (_time.weekday - 1)));
    var weekPresenter = Provider.of<WeekPresenter>(context, listen: false);
    LogUtil.e(
        "_getTimeWidget   ${weekPresenter.currentWeekIndex}    ${weekPresenter.currentPageIndex}   ${index}   ${pageIndex}   ${value.currentWeekIndex}");
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
    var weekPresenter = Provider.of<WeekPresenter>(context, listen: false);
    return weekPresenter.currentPageIndex == pageIndex &&
        weekPresenter.currentWeekIndex == index;
  }

  double _getWeekItemWidth() {
    return window.physicalSize.width / window.devicePixelRatio / 7;
  }
}
