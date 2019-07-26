import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/date_model.dart';
import 'package:flutter_calendar/utils/math_util.dart';

class DialogPageModel with ChangeNotifier {
  bool showCalendar = false;

  bool disabled = false;
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;

  int initialIndex = 0;

  DateModel get selectDate => _selectDate;

  String timeTxt = DateUtil.formatDate(DateTime.now(), format: "MM月dd日") +
      " ${DateUtil.getZHWeekDay(DateTime.now())}";

  DateModel _selectDate = DateModel()
    ..year = DateTime.now().year
    ..month = DateTime.now().month
    ..day = DateTime.now().day;

  List<int> initTimePoint = [
    0,
    DateTime.now().hour,
    DateTime.now().minute ~/ 5,
    0
  ];

  List<int> initTimeDistanceStart = [
    0,
    DateTime.now().hour,
    DateTime.now().minute ~/ 5
  ];
  List<int> initTimeDistanceEnd = [
    DateTime.now().hour + 1,
    DateTime.now().minute ~/ 5,
    0
  ];

  void setShowCalendar(bool show) {
    this.showCalendar = show;
    notifyListeners();
  }

  void setDate(year, month) {
    this.year = year;
    this.month = month;
    notifyListeners();
  }

  set selectDate(DateModel value) {
    _selectDate = value;
    this.showCalendar = false;
    this.timeTxt = DateUtil.formatDate(
            DateTime(value.year, value.month, value.day),
            format: "MM月dd日") +
        " ${DateUtil.getZHWeekDay(DateTime(value.year, value.month, value.day))}";
    notifyListeners();
  }

  void setInitialIndex(value) {
    this.initialIndex = value;
  }
}

class DialogTipsModel with ChangeNotifier {
  Text distanceTips = Text("持续1小时");

  void updateTips(
      List<int> initTimeDistanceStart, List<int> initTimeDistanceEnd) {
    int startHour = initTimeDistanceStart[1];

    int startMin = initTimeDistanceStart[2];

    int endHour = initTimeDistanceEnd[0];

    int endMin = initTimeDistanceEnd[1];

    LogUtil.e("  ${initTimeDistanceStart}   ${initTimeDistanceEnd}");

    if (startHour < endHour) {
      if (startMin == endMin) {
        this.distanceTips = Text("持续${endHour - startHour}小时");
      } else {
        var d1 = new DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, startHour, startMin);
        var d2 = new DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, endHour, endMin);

        var difference = d1.difference(d2);
        LogUtil.e("  ${difference}  ");

        if (difference.inHours == 0) {
          this.distanceTips = Text(
              "持续${difference.inMinutes.abs()}分钟");
        } else {}
        this.distanceTips = Text(
            "持续${difference.inHours.abs()}小时${difference.inMinutes.abs()}分钟");
      }
    } else {
      this.distanceTips = Text(
        "时间段不能跨天设置",
        style: TextStyle(color: Colors.red),
      );
    }

    notifyListeners();
  }
}
