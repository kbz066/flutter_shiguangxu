import 'dart:math';

import 'package:flutter/material.dart';

import 'TodayCircleWidget.dart';

class TodayPullListHeaderWidget extends StatefulWidget {
  List _headerTitleList = [
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

  List _headerImageList = [
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

  double _offset;
  double _containerHeight;
  double _listHeight;
  bool _arrivedListHeight = false;

  TodayPullListHeaderWidget(
      this._listHeight, this._offset, this._arrivedListHeight) {
    _containerHeight = _listHeight / 2;
  }
  @override
  State createState() => new TodayPullListHeaderWidgetState();
}

class TodayPullListHeaderWidgetState extends State<TodayPullListHeaderWidget> {
  double _percent = 1;
  double _circleOpacity = 1;

  double _circleTranslationY = 0;
  double _listTranslationY = 0;
  double _circleHeight = 15;

  @override
  void didUpdateWidget(TodayPullListHeaderWidget oldWidget) {
    pull();
  }

  @override
  Widget build(BuildContext context) {
//    print("build  ${widget._listHeight}    ${_circleHeight}");

    return Container(
      height: widget._listHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: widget._listHeight,
              transform: Matrix4.translationValues(0, _listTranslationY, 0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget._headerImageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Image.asset(
                                "assets/images/${widget._headerImageList[index]}"),
                          ),
                          Text("${widget._headerTitleList[index]}")
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: _circleOpacity,
              child: TodayCircleWidget(_percent, _circleHeight),
            ),
          )
        ],
      ),
    );
  }

  pull() {
    var offset = widget._offset;
    var containerHeight = widget._containerHeight;

    if (!widget._arrivedListHeight) {
//      mExpendPoint.setVisibility(VISIBLE);
      double percent = offset.abs() / containerHeight;
      double moreOffset = offset.abs() - containerHeight;
      //  Log.e("滑动   moreOffsetxx",moreOffset+"     "+offset);

      if (percent <= 1.0) {
        _percent = percent;
        _circleTranslationY = -offset.abs() / 2 + _circleHeight / 2;

        _listTranslationY = -containerHeight;

        // Log.e("滑动   moreOffset33333","    "+(-Math.abs(offset) / 2 + mExpendPoint.getHeight() / 2));
//                Log.e("滑动   moreOffset22",containerHeight+"");
//
//                Log.e("打印   ","mExpendPoint   "+(Math.abs(offset) / 2 - mExpendPoint.getHeight() / 2)+"      "+containerHeight);
      } else {
        double subPercent =
            (moreOffset) / (widget._listHeight - containerHeight);
        subPercent = min(1.0, subPercent);
        _circleTranslationY = -containerHeight / 2 +
            _circleHeight / 2 +
            containerHeight * subPercent / 2;

        _percent = 1;
        double alpha = (1 - subPercent * 2);

        _circleOpacity = max(alpha, 0);

        _listTranslationY = -(1 - subPercent) * containerHeight;

        //Log.e("滑动 --->  moreOffset333",(-(1 - subPercent) * containerHeight)+"");
      }
    }
    if (offset.abs() >= widget._listHeight) {
      _circleOpacity=0;
      _listTranslationY=-(offset.abs() - widget._listHeight) / 2;

    }
  }
}
