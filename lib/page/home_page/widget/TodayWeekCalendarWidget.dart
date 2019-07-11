import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/common/EventBusUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/event/TodayContentIndexEvent.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/TodayMoveTriangleWidget.dart';

class HomeWeekCalendarWidget extends StatefulWidget {
  Function(int index) moveIndex;

  WeekCalendarInfo _weekCalendarInfo;

  HomeWeekCalendarWidget(this.moveIndex, this._weekCalendarInfo);

  @override
  HomeWeekCalendarWidgetState createState() =>
      HomeWeekCalendarWidgetState(moveIndex, _weekCalendarInfo);
}

class HomeWeekCalendarWidgetState extends State<HomeWeekCalendarWidget> {
  WeekCalendarInfo _weekCalendarInfo;

  Function(int index) moveIndex;

  PageController _transController;

  HomeWeekCalendarWidgetState(this.moveIndex, this._weekCalendarInfo);

  void initState() {
    super.initState();

    _transController = new PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.mainColor,
      height: 55,
      child: Listener(
        onPointerUp: (e) {
          print("抬起手指    ${_transController.page}");
        },
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
                              moveIndex(_weekCalendarInfo._currentWeekIndex);
                              EventBusUtils.instance.eventBus.fire(TodayContentIndexEvent(pageIndex*7+index));
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
    print("_onPageChanged    " + index.toString());
    setState(() {
      if (_weekCalendarInfo.currentPageIndex < index) {
        _weekCalendarInfo._currentWeekIndex = 0;
      } else {
        _weekCalendarInfo._currentWeekIndex = 6;
      }


      _weekCalendarInfo.currentPageIndex = index;
      EventBusUtils.instance.eventBus.fire(TodayContentIndexEvent(index*7+_weekCalendarInfo.currentWeekIndex));

    });
    moveIndex(_weekCalendarInfo._currentWeekIndex);

    print("index      " + index.toString());
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
}
