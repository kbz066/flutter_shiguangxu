import 'dart:math';

import 'package:flutter/material.dart';

import '../page/schedule_page/widget/TodayCircleWidget.dart';

class PullListHeader extends StatefulWidget {


  double _offset;
  double _containerHeight;
  double _listHeight;
  bool _arrivedListHeight = false;
  Widget _child;

  PullListHeader(
      this._listHeight, this._offset, this._arrivedListHeight,this._child) {
    _containerHeight = _listHeight / 2;
  }
  @override
  State createState() => new PullListHeaderState();
}

class PullListHeaderState extends State<PullListHeader> {
  double _percent = 1;
  double _circleOpacity = 1;

  double _circleTranslationY = 0;
  double _listTranslationY = 0;
  double _circleHeight = 15;

  @override
  void didUpdateWidget(PullListHeader oldWidget) {
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
              child: widget._child
             ,
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
