import 'package:flustars/flustars.dart';
import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';

class ScheduleDatePresenter extends BasePresenter {
  ScheduleDatePresenter() : super(null);

  var weekTitles = ["一", "二", "三", "四", "五", "六", "日"];

  var startTime =  DateTime(2019,1,1);
  var dateTotalSize =
      DateTime(2019,1,1).difference(DateTime(2020, 12, 31)).inDays.abs();
  var currentPageIndex =  (DateTime(2019,1,1).difference(DateTime.now()).inDays.abs()/7).ceil();
  var currentWeekIndex = DateTime.now().weekday - 1;


  DateTime getNewCurrentTime(){
    return  startTime.add(Duration(days: currentPageIndex * 7 +
       currentWeekIndex -
        (startTime.weekday - 1)));
  }


  void setIndex(currentPageIndex,currentWeekIndex){
    this.currentPageIndex=currentPageIndex;
    this.currentWeekIndex=currentWeekIndex;
    notifyListeners();
  }

}
