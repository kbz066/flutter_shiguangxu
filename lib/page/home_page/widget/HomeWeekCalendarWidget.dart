import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_shiguangxu/common/ColorUtils.dart';
import 'package:flutter_shiguangxu/page/home_page/widget/HomeMoveTriangleWidget.dart';

class HomeWeekCalendarWidget extends StatefulWidget {
  Function(int index) moveIndex;

  HomeWeekCalendarWidget(this.moveIndex);

  @override
  HomeWeekCalendarWidgetState createState() =>
      new HomeWeekCalendarWidgetState(moveIndex);
}

class HomeWeekCalendarWidgetState extends State<HomeWeekCalendarWidget> {
  var _time;

  var _weekTitles;
  var _duration;
  var _currentPageIndex;
  var _currentWeekIndex;
  var _lastCurrentWeekIndex;
  Function(int index) moveIndex;

  PageController _transController;

  HomeWeekCalendarWidgetState(this.moveIndex);

  void initState() {
    super.initState();
    _time = DateTime.now();
    _transController = new PageController();
    _weekTitles = ["一", "二", "三", "四", "五", "六", "日"];
    _duration = DateTime.now().difference(DateTime(2020, 12, 31));
    _currentPageIndex = 0;
    _currentWeekIndex = DateTime.now().weekday - 1;
    _lastCurrentWeekIndex=_currentWeekIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    print("日期控件 biuld");
    return Container(
      color: ColorUtils.mainColor,
      height: 60,
      child: Listener(
        onPointerUp: (e) {
          print("抬起手指    ${_transController.page}");
        },
        child: PageView.builder(
          controller: _transController,
          itemCount: (_duration.inDays.abs() / 7).ceil(),
          itemBuilder: (BuildContext context, int pageIndex) {
            return Stack(
              children: <Widget>[
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _weekTitles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7, childAspectRatio: 0.5),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Text("${_weekTitles[index]}",
                            style: TextStyle(color: Colors.white70)),
                        InkWell(
                          onTap: () {
                            print("点击的 index   ${index}    ${pageIndex}   ");
                            setState(() {
                              _currentWeekIndex = index;
                              _currentPageIndex = pageIndex;
                              moveIndex(_currentWeekIndex);
                            });
                          },
                          child: _getTimeWidget(_time, index, pageIndex),
                        )
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  child: HomeMoveTriangleWidget(
                      EdgeInsets.only(
                          left: _lastCurrentWeekIndex * _getWeekItemWidth()),
                      EdgeInsets.only(
                          left: (_currentWeekIndex - _lastCurrentWeekIndex) *
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

  _startAni() {}
  _onPageChanged(index) {
    print("_onPageChanged    " + index.toString());
    setState(() {
      if (_currentPageIndex < index) {
        _currentWeekIndex = 0;
      } else {
        _currentWeekIndex = 6;
      }
      _currentPageIndex = index;
    });
    moveIndex(_currentWeekIndex);

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
                color:
                    isCheckIndex(index, pageIndex) ? Colors.white : Colors.red,
                shape: BoxShape.circle),
            child: Text("${(_nowDuration.day.toString())}",
                style: TextStyle(
                    color: isCheckIndex(index, pageIndex)
                        ? ColorUtils.mainColor
                        : Colors.white70)),
          );
  }

  isCheckIndex(index, pageIndex) {
    return _currentPageIndex == pageIndex && _currentWeekIndex == index;
  }

  double _getWeekItemWidth() {
    return window.physicalSize.width / window.devicePixelRatio / 7;
  }
}
