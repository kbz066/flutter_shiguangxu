import 'package:flutter_shiguangxu/base/BaseModel.dart';
import 'package:flutter_shiguangxu/base/BasePresenter.dart';

class WeekPresenter extends BasePresenter {
  WeekPresenter() : super(null);

  var weekTitles = ["一", "二", "三", "四", "五", "六", "日"];
  var currentPageIndex = 0;
  var currentTime = DateTime.now();
  var dateTotalSize =
      DateTime.now().difference(DateTime(2020, 12, 31)).inDays.abs();

  var currentWeekIndex = DateTime.now().weekday - 1;


  DateTime getNewCurrentTime(){
    return   DateTime.now().add(Duration(days: currentPageIndex * 7 +
       currentWeekIndex -
        (currentTime.weekday - 1)));
  }

  void setIndex(currentPageIndex,currentWeekIndex){
    this.currentPageIndex=currentPageIndex;
    this.currentWeekIndex=currentWeekIndex;
    notifyListeners();
  }

}
