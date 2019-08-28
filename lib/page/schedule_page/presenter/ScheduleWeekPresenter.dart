
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar/utils/math_util.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';


import 'package:flutter_shiguangxu/page/schedule_page/model/ScheduleModel.dart';



import 'package:flutter_shiguangxu/utils/HttpUtils.dart';

class ScheduleWeekPresenter extends BasePresenter{
  ScheduleWeekPresenter() : super(ScheduleModel());

  var weekTitles = ["一", "二", "三", "四", "五", "六", "日"];

  var startTime =  DateTime(2019,1,1);
  var dateTotalSize = DateTime(2019,1,1).difference(DateTime(2020, 12, 31)).inDays.abs();
  var currentPageIndex =  (DateTime(2019,1,1).difference(DateTime.now()).inDays.abs()/7).ceil();
  var currentWeekIndex = DateTime.now().weekday - 1;


  DateTime getNewCurrentTime(int page,int index){


    return   startTime.add(Duration(days: page * 7 +
        index -
        (startTime.weekday - 1)));
  }


  void setIndex(currentPageIndex){
    this.currentPageIndex=currentPageIndex;

    notifyListeners();
  }

  String getWeekOfMonth(){
    var time=startTime.add(Duration(days: currentPageIndex * 7 +

        (startTime.weekday - 1)));
    return "${time.month}月 第${(time.day/7).ceil()}周";
  }


}