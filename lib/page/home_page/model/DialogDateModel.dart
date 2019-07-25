import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class DialogDateModel with ChangeNotifier{
  String _timeTxt=DateUtil.formatDate(DateTime.now(),format: "MM月dd日")+" ${DateUtil.getZHWeekDay(DateTime.now())}";
  String _distanceTips="持续1小时";


  String get timeTxt => _timeTxt;


  String get distanceTips => _distanceTips;

  void setTimeTxt(String time){
    this._timeTxt=time;
    notifyListeners();
  }

}