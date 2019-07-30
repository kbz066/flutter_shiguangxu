import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';


import 'DialogStateModel.dart';

class TodayStateModel extends ChangeNotifier{
  bool showType=false;
  bool showLevel=false;

  bool updateTypeIcon=false;
  int checkTypeIndex=2;

  bool updateLeveleIcon=false;
  int checkLevelIndex=1;


  bool selectDate=false;

  String dateTips;


  void  setShowTypeView(){
    this.showType=!showType;
    notifyListeners();
  }


  void  setShowLevelView(){
    this.showType=false;
    this.showLevel=!showLevel;
    notifyListeners();
  }

  void setCheckTypeIndex(index){
    this.checkTypeIndex=index;
    this.updateTypeIcon=true;
    setShowTypeView();
  }

  void setCheckLevelIndex(index){
    this.checkLevelIndex=index;
    this.updateLeveleIcon=true;
    setShowLevelView();
  }
  void setSelectDate(selectDate, DialogPageModel pageModel, int index){
    this.selectDate=selectDate;
    this.showLevel=false;
    this.showType=false;




    String tips = null;

    if(pageModel!=null){
      switch (index) {
        case 0:
          tips =
          "${pageModel.selectDate.year}年${pageModel.selectDate.month}月${pageModel.selectDate.day}日 "
              "${DateUtil.getZHWeekDay(DateTime(pageModel.selectDate.year,pageModel.selectDate.month,pageModel.selectDate.day)
          )} ${pageModel.initTimePoint[1]}:${pageModel.initTimePoint[2]}";
          break;

        case 1:
          tips =
          "${pageModel.selectDate.year}年${pageModel.selectDate.month}月${pageModel.selectDate.day}日 "
              "${DateUtil.getZHWeekDay(DateTime(pageModel.selectDate.year,pageModel.selectDate.month,pageModel.selectDate.day)
          )} ${pageModel.initTimeDistanceStart[1]}:${pageModel.initTimeDistanceStart[2]}~${pageModel.initTimeDistanceEnd[0]}:${pageModel.initTimeDistanceEnd[1]}";
          break;
        case 1:
          tips =
          "${pageModel.selectDate.year}年${pageModel.selectDate.month}月${pageModel.selectDate.day}日 "
              "${DateUtil.getZHWeekDay(DateTime(pageModel.selectDate.year,pageModel.selectDate.month,pageModel.selectDate.day)
          )} ";
          break;
      }
    }
    this.dateTips=tips;
    notifyListeners();
  }



}